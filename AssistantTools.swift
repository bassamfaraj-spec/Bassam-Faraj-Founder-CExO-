import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

#if canImport(FoundationModels)
@available(iOS 26.0, macOS 26.0, *)
struct GenerateDocsTool: Tool {
    let name = "generateDocuments"
    let description = "Generate the standard founder documents."

    @Generable
    struct Arguments {
        @Guide(description: "Body only")
        var bodyOnly: Bool
    }

    func call(arguments: Arguments) async throws -> String {
        // We cannot directly call SwiftUI view methods here. Return a plan.
        let summary = bodyOnlySummary(arguments.bodyOnly)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .assistantGenerateDocs, object: nil, userInfo: [AssistantActionKeys.bodyOnly: arguments.bodyOnly])
        }
        return "Preparing to generate all docs. \(summary)"
    }

    private func bodyOnlySummary(_ flag: Bool) -> String { flag ? "Body only enabled." : "Using letterhead." }
}

@available(iOS 26.0, macOS 26.0, *)
struct CreateInvoiceTool: Tool {
    let name = "createInvoice"
    let description = "Create an hourly invoice."

    @Generable
    struct Arguments {
        @Guide(description: "Client name")
        var billToName: String

        @Guide(description: "Billable hours")
        var hours: Double

        @Guide(description: "Hourly rate")
        var hourlyRate: Double
    }

    func call(arguments: Arguments) async throws -> String {
        let h = arguments.hours
        let r = arguments.hourlyRate
        let amount = h * r
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .assistantCreateInvoice, object: nil, userInfo: [
                AssistantActionKeys.billToName: arguments.billToName,
                AssistantActionKeys.hours: arguments.hours,
                AssistantActionKeys.hourlyRate: arguments.hourlyRate
            ])
        }
        return "Invoice prepared for \(arguments.billToName): \(h)h @ \(r) = \(String(format: "%.2f", amount)). Open the app to finalize."
    }
}

@available(iOS 26.0, macOS 26.0, *)
struct RestoreVerifyTool: Tool {
    let name = "restoreVerifyPurchases"
    let description = "Restore and verify App Store purchases."

    @Generable
    struct Arguments {}

    func call(arguments: Arguments) async throws -> String {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .assistantRestoreVerify, object: nil)
        }
        return "Starting restore and verify. Open the app to view status."
    }
}

@available(iOS 26.0, macOS 26.0, *)
struct RunInitiativeTool: Tool {
    let name = "runInitiative"
    let description = "Create the Initiative launch and security shield checklist."

    @Generable
    struct Arguments {
        @Guide(description: "Primary focus")
        var focus: String

        @Guide(description: "Include contact routing")
        var includeContactRouting: Bool
    }

    func call(arguments: Arguments) async throws -> String {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .assistantRunInitiative, object: nil, userInfo: [
                AssistantActionKeys.focus: arguments.focus,
                AssistantActionKeys.includeContactRouting: arguments.includeContactRouting
            ])
        }
        return "Initiative launch and security shield plan queued for \(arguments.focus)."
    }
}

@available(iOS 26.0, macOS 26.0, *)
struct GenerateKeelportCascadeTool: Tool {
    let name = "generateKeelportCascade"
    let description = "Create the Keelport AR Infusion cascade plan."

    @Generable
    struct Arguments {
        @Guide(description: "Primary focus")
        var focus: String

        @Guide(description: "App Store Connect checklist")
        var includeAppStoreConnectChecklist: Bool

        @Guide(description: "Adult and substance safety")
        var includeAdultAndSubstanceSafety: Bool
    }

    func call(arguments: Arguments) async throws -> String {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .assistantGenerateKeelportCascade, object: nil, userInfo: [
                AssistantActionKeys.focus: arguments.focus,
                AssistantActionKeys.includeAppStoreConnectChecklist: arguments.includeAppStoreConnectChecklist,
                AssistantActionKeys.includeAdultAndSubstanceSafety: arguments.includeAdultAndSubstanceSafety
            ])
        }
        return "Keelport AR Infusion cascade plan queued for \(arguments.focus)."
    }
}

#endif
