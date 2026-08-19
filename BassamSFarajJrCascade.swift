import Foundation

public enum KeelportMarketCategory: String, CaseIterable, Codable, Sendable {
    case personal
    case work
    case family
    case healthWellness
    case artsEntertainment
    case sportsRecreation
    case technology
    case travel
    case leisure
    case adultWellness
    case substanceHarmReduction
    case safetyEducation

    public var title: String {
        switch self {
        case .personal: return "Personal"
        case .work: return "Work"
        case .family: return "Family"
        case .healthWellness: return "Health and Wellness"
        case .artsEntertainment: return "Arts and Entertainment"
        case .sportsRecreation: return "Sports and Recreation"
        case .technology: return "Technology"
        case .travel: return "Travel"
        case .leisure: return "Leisure"
        case .adultWellness: return "Adult Wellness"
        case .substanceHarmReduction: return "Substance Harm Reduction"
        case .safetyEducation: return "Safety Education"
        }
    }
}

public struct KeelportMediaTier: Equatable, Hashable, Codable, Sendable {
    public var name: String
    public var photoTarget: String
    public var videoTarget: String
    public var validationGate: String

    public init(name: String, photoTarget: String, videoTarget: String, validationGate: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.photoTarget = photoTarget.trimmingCharacters(in: .whitespacesAndNewlines)
        self.videoTarget = videoTarget.trimmingCharacters(in: .whitespacesAndNewlines)
        self.validationGate = validationGate.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportCascadePlan: Equatable, Hashable, Codable, Sendable {
    public var name: String
    public var focus: String
    public var categories: [KeelportMarketCategory]
    public var mediaTiers: [KeelportMediaTier]
    public var includeAppStoreConnectChecklist: Bool
    public var includeAdultAndSubstanceSafety: Bool

    public init(
        name: String = "Keelport AR Infusion Cascade",
        focus: String,
        categories: [KeelportMarketCategory] = KeelportMarketCategory.allCases,
        mediaTiers: [KeelportMediaTier] = KeelportCascadePlan.defaultMediaTiers,
        includeAppStoreConnectChecklist: Bool = true,
        includeAdultAndSubstanceSafety: Bool = true
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.focus = focus.trimmingCharacters(in: .whitespacesAndNewlines)
        self.categories = categories
        self.mediaTiers = mediaTiers
        self.includeAppStoreConnectChecklist = includeAppStoreConnectChecklist
        self.includeAdultAndSubstanceSafety = includeAdultAndSubstanceSafety
    }

    public static let defaultMediaTiers: [KeelportMediaTier] = [
        KeelportMediaTier(
            name: "Current Device",
            photoTarget: "8 MP to 48 MP source assets where supported by hardware",
            videoTarget: "4K to 8K capture/export where supported by hardware",
            validationGate: "Use only device-reported camera and encoder capabilities."
        ),
        KeelportMediaTier(
            name: "Pro Production",
            photoTarget: "48 MP to 240 MP composite or stitched output after provenance review",
            videoTarget: "8K to 10K editorial export when source quality supports it",
            validationGate: "No public quality claim without render proof, file inspection, and playback testing."
        ),
        KeelportMediaTier(
            name: "Future Lab",
            photoTarget: "16K, 24K, 48K, 96K, and higher labels treated as lab or display-wall targets",
            videoTarget: "Beyond-10K experiences require explicit device, codec, storage, and display validation",
            validationGate: "Never advertise future/lab tiers as live product capability until measured."
        )
    ]

    public func markdown(bodyOnly: Bool = false) -> String {
        var lines: [String] = [
            "# \(name)",
            "",
            "Focus: \(focus.isEmpty ? "AR assistants, product cascade, media quality, and AI safety" : focus)",
            "",
            "## Run Destination",
            "- Use Fastlane lane `build_keelport` or `xcodebuild` with `XCODE_DESTINATION` set.",
            "- Default automation builds against `generic/platform=iOS Simulator` so it does not depend on the Xcode UI selected destination.",
            "- Use `generic/platform=iOS` for physical-device archive/build checks when signing is configured.",
            "- If simulator runtime services are unavailable, build-only verification can still run with a generic destination.",
            "",
            "## AR Infusion Assistants",
            "- Start with document, launch, billing, security, media, and moderation assistants.",
            "- Keep AR assistants grounded in local app state and explicit user actions.",
            "- Do not let assistants claim provider, carrier, email, Apple, or App Store Connect access unless credentials and APIs are connected.",
            "- Separate customer-facing AR experience from private account recovery and partner data.",
            "",
            "## Market Cascade"
        ]

        lines.append(contentsOf: categories.map { "- \($0.title): localize offers, safety copy, access, pricing, media format, and support path market by market." })

        lines.append(contentsOf: [
            "",
            "## Media Standard"
        ])
        for tier in mediaTiers {
            lines.append("- \(tier.name): \(tier.photoTarget); \(tier.videoTarget). Gate: \(tier.validationGate)")
        }

        lines.append(contentsOf: [
            "",
            "## Speed and Reliability Gates",
            "- Build gate: no release branch without a clean Xcode build.",
            "- Launch gate: app opens, generates all documents, creates an invoice, and returns assistant status messages.",
            "- Media gate: every claimed resolution has inspected source dimensions, codec, bitrate, color space, and playback proof.",
            "- Reliability gate: failed provider calls degrade to local documents or clear user action, not silent failure.",
            "- Safety gate: moderation and age gating are tested before worldwide rollout.",
            "",
            "## AI Safety Standard",
            "- Remove or disable legacy prompts, models, keys, automations, and assistants that cannot be audited.",
            "- Require source-grounded answers for health, safety, finance, legal, adult, and substance-related topics.",
            "- Use age gating, consent checks, and policy review for adult wellness content.",
            "- Use harm-reduction framing for substance topics; do not provide instructions for illegal procurement or unsafe use.",
            "- Keep beauty filters natural, reversible, labeled where appropriate, and respectful of skin tone, identity, disability, and consent."
        ])

        if includeAppStoreConnectChecklist {
            lines.append(contentsOf: [
                "",
                "## App Store Connect Handoff",
                "- Create an App Store Connect API key outside this repository.",
                "- Store key ID, issuer ID, and private key content in a secret manager or CI secret, not in source control.",
                "- Import app inventory by bundle ID, SKU, Apple ID, platform, version, entitlement, privacy manifest, and review status.",
                "- Map each Apple Developer certificate, profile, device, capability, and bundle ID to a Keelport release record.",
                "- Revoke and rotate any API key, certificate, provisioning profile, or signing identity that cannot be accounted for."
            ])
        }

        if includeAdultAndSubstanceSafety {
            lines.append(contentsOf: [
                "",
                "## Adult and Substance Moderation",
                "- Adult wellness areas require age gates, consent language, privacy protection, and market-specific legal review.",
                "- Substance-related content must stay factual, safety-oriented, and market-specific.",
                "- Block exploitative, non-consensual, underage, illegal procurement, evasion, and medical-claim content.",
                "- Escalate uncertain cases to human review before publishing or monetizing."
            ])
        }

        let body = lines.joined(separator: "\n")
        if bodyOnly {
            return body
        }

        let letterhead = Letterhead(
            style: BrandPalette.founderPersonal,
            kind: .program,
            subtitle: "AR Infusion Product Cascade",
            disclaimer: "Planning artifact. External Apple, carrier, email, and provider integrations require credentialed access and review."
        )
        return DocumentBranding.prependLetterhead(body, letterhead: letterhead)
    }
}

public enum KeelportCascadeGenerator {
    @discardableResult
    public static func write(
        to directory: URL,
        focus: String = "AR assistants, product cascade, media quality, and AI safety",
        includeAppStoreConnectChecklist: Bool = true,
        includeAdultAndSubstanceSafety: Bool = true,
        bodyOnly: Bool = false
    ) throws -> URL {
        let plan = KeelportCascadePlan(
            focus: focus,
            includeAppStoreConnectChecklist: includeAppStoreConnectChecklist,
            includeAdultAndSubstanceSafety: includeAdultAndSubstanceSafety
        )
        let content = plan.markdown(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("Keelport_AR_Infusion_Cascade.md")
        try Data(content.utf8).write(to: url)
        return url
    }
}
