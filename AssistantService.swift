import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

public final class AssistantService {
    public static let shared = AssistantService()
    private init() {}

    public enum AssistantError: LocalizedError {
        case unavailable
        case missingAPIKey
        case apiError(String)

        public var errorDescription: String? {
            switch self {
            case .unavailable:
                return "Assistant is unavailable on this device."
            case .missingAPIKey:
                return "No API key configured for ChatGPT fallback. Set OPENAI_API_KEY in environment or Info.plist."
            case .apiError(let message):
                return message
            }
        }
    }

    public static let defaultInstructions = """
    You are Phoenix, a concise, helpful assistant. Provide accurate, actionable responses.
    Keep answers brief by default. When you need to list steps, use bullet points.
    Do not claim access to prior ChatGPT/OpenAI history, carrier systems, email inboxes, device logs, or account settings unless this app has explicit data or tool access.
    For suspected phone, email, account, or spyware compromise, give evidence-based recovery steps: rotate credentials, enable MFA, remove unknown devices, check forwarding and carrier port protection, preserve evidence, and escalate to the provider when required.
    Treat phone numbers, email aliases, account keys, and recovery details as sensitive. Do not hardcode or publish private contact routing.
    Keep AI safety grounded: reject unsupported capability claims, require validation for media-quality claims, apply age and consent gates for adult topics, and use harm-reduction framing for substance-related topics.
    You can use tools when appropriate to perform actions:
    - GenerateDocsTool(bodyOnly: Bool)
    - CreateInvoiceTool(billToName: String, hours: Double, hourlyRate: Double)
    - RestoreVerifyTool()
    - RunInitiativeTool(focus: String, includeContactRouting: Bool)
    - GenerateKeelportCascadeTool(focus: String, includeAppStoreConnectChecklist: Bool, includeAdultAndSubstanceSafety: Bool)
    """

    #if canImport(FoundationModels)
    @available(iOS 26.0, macOS 26.0, *)
    private var fmTools: [any Tool] {
        [GenerateDocsTool(), CreateInvoiceTool(), RestoreVerifyTool(), RunInitiativeTool(), GenerateKeelportCascadeTool()]
    }
    #endif

    public func respond(to prompt: String, localOnly: Bool) async throws -> String {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, macOS 26.0, *) {
            let model = SystemLanguageModel.default
            switch model.availability {
            case .available:
                let session = LanguageModelSession(tools: fmTools) {
                    Self.defaultInstructions
                }
                let reply = try await session.respond(to: prompt)
                return reply.content
            default:
                if localOnly { throw AssistantError.unavailable }
                return try await chatGPTFallback(prompt: prompt)
            }
        } else {
            if localOnly { throw AssistantError.unavailable }
            return try await chatGPTFallback(prompt: prompt)
        }
        #else
        if localOnly { throw AssistantError.unavailable }
        return try await chatGPTFallback(prompt: prompt)
        #endif
    }

    public func respond(to prompt: String) async throws -> String {
        return try await respond(to: prompt, localOnly: false)
    }

    public func stream(to prompt: String, localOnly: Bool) -> AsyncThrowingStream<String, Error> {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, macOS 26.0, *) {
            let model = SystemLanguageModel.default
            switch model.availability {
            case .available:
                return AsyncThrowingStream { continuation in
                    Task {
                        do {
                            let session = LanguageModelSession(tools: fmTools) {
                                Self.defaultInstructions
                            }
                            let stream = session.streamResponse(to: prompt)
                            for try await snapshot in stream {
                                continuation.yield(snapshot.content)
                            }
                            continuation.finish()
                        } catch {
                            continuation.finish(throwing: error)
                        }
                    }
                }
            default:
                if localOnly {
                    return AsyncThrowingStream { $0.finish(throwing: AssistantError.unavailable) }
                }
                return AsyncThrowingStream { continuation in
                    Task {
                        do {
                            let reply = try await self.chatGPTFallback(prompt: prompt)
                            continuation.yield(reply)
                            continuation.finish()
                        } catch {
                            continuation.finish(throwing: error)
                        }
                    }
                }
            }
        }
        #endif
        if localOnly {
            return AsyncThrowingStream { $0.finish(throwing: AssistantError.unavailable) }
        }
        return AsyncThrowingStream { continuation in
            Task {
                do {
                    let reply = try await self.chatGPTFallback(prompt: prompt)
                    continuation.yield(reply)
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    public func stream(to prompt: String) -> AsyncThrowingStream<String, Error> {
        return stream(to: prompt, localOnly: false)
    }

    private func chatGPTFallback(prompt: String) async throws -> String {
        let client = ChatGPTClient()
        return try await client.chat(prompt: prompt)
    }
}
