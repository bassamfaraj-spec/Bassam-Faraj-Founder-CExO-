import Foundation

extension Notification.Name {
    static let assistantGenerateDocs = Notification.Name("assistant.generateDocs")
    static let assistantCreateInvoice = Notification.Name("assistant.createInvoice")
    static let assistantRestoreVerify = Notification.Name("assistant.restoreVerify")
    static let assistantRunInitiative = Notification.Name("assistant.runInitiative")
    static let assistantGenerateKeelportCascade = Notification.Name("assistant.generateKeelportCascade")
    static let assistantGenerateHiResHandoff = Notification.Name("assistant.generateHiResHandoff")
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
    static let mediaPlatform = "mediaPlatform"
    static let mediaProfile = "mediaProfile"
    static let mediaQualityGoal = "mediaQualityGoal"
    static let mediaFormat = "mediaFormat"
    static let faceTimeIntegration = "faceTimeIntegration"
    static let videoChatIntegration = "videoChatIntegration"
    static let mediaEarlyAccessOnly = "mediaEarlyAccessOnly"
}
