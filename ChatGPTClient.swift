import Foundation

public final class ChatGPTClient {
    private let session: URLSession
    private let apiKey: String?
    private let model: String
    private let endpoint: URL

    public init(
        session: URLSession = .shared,
        apiKey: String? = ChatGPTClient.configurationValue("OPENAI_API_KEY"),
        model: String = ChatGPTClient.configurationValue("OPENAI_MODEL") ?? "gpt-5",
        endpoint: URL = URL(string: "https://api.openai.com/v1/responses")!
    ) {
        self.session = session
        self.apiKey = apiKey?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.model = model
        self.endpoint = endpoint
    }

    public func chat(prompt: String) async throws -> String {
        guard let apiKey, !apiKey.isEmpty else {
            throw AssistantService.AssistantError.missingAPIKey
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body = ResponsesRequest(
            model: model,
            instructions: AssistantService.defaultInstructions,
            input: prompt,
            store: false
        )
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AssistantService.AssistantError.apiError("OpenAI returned a non-HTTP response.")
        }

        let decoded = try JSONDecoder().decode(ResponsesResponse.self, from: data)
        if let error = decoded.error {
            throw AssistantService.AssistantError.apiError(error.message)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw AssistantService.AssistantError.apiError("OpenAI request failed with HTTP \(httpResponse.statusCode).")
        }

        let text = decoded.resolvedText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            throw AssistantService.AssistantError.apiError("OpenAI returned an empty response.")
        }
        return text
    }

    private static func configurationValue(_ key: String) -> String? {
        if let value = ProcessInfo.processInfo.environment[key], !value.isEmpty {
            return value
        }
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}

private struct ResponsesRequest: Encodable {
    let model: String
    let instructions: String
    let input: String
    let store: Bool
}

private struct ResponsesResponse: Decodable {
    let outputText: String?
    let output: [ResponseOutputItem]?
    let error: ResponseError?

    var resolvedText: String {
        if let outputText, !outputText.isEmpty {
            return outputText
        }

        return output?
            .compactMap(\.content)
            .flatMap { $0 }
            .compactMap(\.text)
            .joined(separator: "\n") ?? ""
    }

    private enum CodingKeys: String, CodingKey {
        case outputText = "output_text"
        case output
        case error
    }
}

private struct ResponseOutputItem: Decodable {
    let content: [ResponseContent]?
}

private struct ResponseContent: Decodable {
    let text: String?
}

private struct ResponseError: Decodable {
    let message: String
}
