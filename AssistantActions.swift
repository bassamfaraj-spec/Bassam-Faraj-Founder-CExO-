import Foundation

extension Notification.Name {
    static let assistantGenerateDocs = Notification.Name("assistant.generateDocs")
    static let assistantCreateInvoice = Notification.Name("assistant.createInvoice")
    static let assistantRestoreVerify = Notification.Name("assistant.restoreVerify")
    static let assistantRunInitiative = Notification.Name("assistant.runInitiative")
    static let assistantGenerateKeelportCascade = Notification.Name("assistant.generateKeelportCascade")
}

enum AssistantActionKeys {
    static let bodyOnly = "bodyOnly"
    static let billToName = "billToName"
    static let hours = "hours"
    static let hourlyRate = "hourlyRate"
    static let focus = "focus"
    static let includeContactRouting = "includeContactRouting"
    static let includeAppStoreConnectChecklist = "includeAppStoreConnectChecklist"
    static let includeAdultAndSubstanceSafety = "includeAdultAndSubstanceSafety"
}
