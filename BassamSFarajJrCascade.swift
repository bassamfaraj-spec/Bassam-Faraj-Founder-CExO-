import Foundation

public enum KeelportMarketCategory: String, CaseIterable, Codable, Sendable {
    case arInfusionMembership
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
        case .arInfusionMembership: return "AR Infusion Membership"
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

public struct KeelportMembershipPlan: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var audience: String
    public var cadence: String
    public var promise: String
    public var includedAccess: [String]

    public init(
        name: String,
        audience: String,
        cadence: String = "Monthly",
        promise: String,
        includedAccess: [String]
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.audience = audience.trimmingCharacters(in: .whitespacesAndNewlines)
        self.cadence = cadence.trimmingCharacters(in: .whitespacesAndNewlines)
        self.promise = promise.trimmingCharacters(in: .whitespacesAndNewlines)
        self.includedAccess = includedAccess.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}

public struct KeelportProductLineupItem: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var launchRole: String
    public var customer: String
    public var marketEdge: String
    public var proofPoint: String
    public var callToAction: String

    public init(
        name: String,
        launchRole: String,
        customer: String,
        marketEdge: String,
        proofPoint: String,
        callToAction: String
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.launchRole = launchRole.trimmingCharacters(in: .whitespacesAndNewlines)
        self.customer = customer.trimmingCharacters(in: .whitespacesAndNewlines)
        self.marketEdge = marketEdge.trimmingCharacters(in: .whitespacesAndNewlines)
        self.proofPoint = proofPoint.trimmingCharacters(in: .whitespacesAndNewlines)
        self.callToAction = callToAction.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportLaunchPlay: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { title }
    public var title: String
    public var channel: String
    public var action: String
    public var metric: String

    public init(title: String, channel: String, action: String, metric: String) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.channel = channel.trimmingCharacters(in: .whitespacesAndNewlines)
        self.action = action.trimmingCharacters(in: .whitespacesAndNewlines)
        self.metric = metric.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportRolloutStage: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { title }
    public var title: String
    public var scope: String
    public var trialAccess: String
    public var requiredProof: String
    public var exitGate: String

    public init(
        title: String,
        scope: String,
        trialAccess: String,
        requiredProof: String,
        exitGate: String
    ) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.scope = scope.trimmingCharacters(in: .whitespacesAndNewlines)
        self.trialAccess = trialAccess.trimmingCharacters(in: .whitespacesAndNewlines)
        self.requiredProof = requiredProof.trimmingCharacters(in: .whitespacesAndNewlines)
        self.exitGate = exitGate.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportTestingHowTo: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { title }
    public var title: String
    public var target: String
    public var steps: [String]
    public var evidence: String

    public init(title: String, target: String, steps: [String], evidence: String) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.target = target.trimmingCharacters(in: .whitespacesAndNewlines)
        self.steps = steps.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        self.evidence = evidence.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportApprovalCheckpoint: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var authority: String
    public var trigger: String
    public var action: String
    public var evidence: String

    public init(name: String, authority: String, trigger: String, action: String, evidence: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.authority = authority.trimmingCharacters(in: .whitespacesAndNewlines)
        self.trigger = trigger.trimmingCharacters(in: .whitespacesAndNewlines)
        self.action = action.trimmingCharacters(in: .whitespacesAndNewlines)
        self.evidence = evidence.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportSuccessMetric: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var measurement: String
    public var healthySignal: String
    public var integrityGuardrail: String

    public init(
        name: String,
        measurement: String,
        healthySignal: String,
        integrityGuardrail: String
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.measurement = measurement.trimmingCharacters(in: .whitespacesAndNewlines)
        self.healthySignal = healthySignal.trimmingCharacters(in: .whitespacesAndNewlines)
        self.integrityGuardrail = integrityGuardrail.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportOperatingSystemStep: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var target: String
    public var action: String
    public var evidence: String
    public var hardStop: String

    public init(
        name: String,
        target: String,
        action: String,
        evidence: String,
        hardStop: String
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.target = target.trimmingCharacters(in: .whitespacesAndNewlines)
        self.action = action.trimmingCharacters(in: .whitespacesAndNewlines)
        self.evidence = evidence.trimmingCharacters(in: .whitespacesAndNewlines)
        self.hardStop = hardStop.trimmingCharacters(in: .whitespacesAndNewlines)
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

public struct KeelportChannelRoute: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var destination: String
    public var confidentiality: String
    public var payload: String
    public var approvalGate: String

    public init(
        name: String,
        destination: String,
        confidentiality: String,
        payload: String,
        approvalGate: String
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.destination = destination.trimmingCharacters(in: .whitespacesAndNewlines)
        self.confidentiality = confidentiality.trimmingCharacters(in: .whitespacesAndNewlines)
        self.payload = payload.trimmingCharacters(in: .whitespacesAndNewlines)
        self.approvalGate = approvalGate.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportHelpTopic: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { title }
    public var title: String
    public var summary: String
    public var steps: [String]
    public var escalation: String

    public init(title: String, summary: String, steps: [String], escalation: String) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.summary = summary.trimmingCharacters(in: .whitespacesAndNewlines)
        self.steps = steps.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        self.escalation = escalation.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct KeelportCascadePlan: Equatable, Hashable, Codable, Sendable {
    public var name: String
    public var focus: String
    public var releaseDate: String
    public var categories: [KeelportMarketCategory]
    public var membershipPlans: [KeelportMembershipPlan]
    public var productLineup: [KeelportProductLineupItem]
    public var launchPlays: [KeelportLaunchPlay]
    public var rolloutStages: [KeelportRolloutStage]
    public var featureServiceReleaseSteps: [KeelportOperatingSystemStep]
    public var testingHowTos: [KeelportTestingHowTo]
    public var approvalCheckpoints: [KeelportApprovalCheckpoint]
    public var successMetrics: [KeelportSuccessMetric]
    public var medicalTeamHandoffSteps: [KeelportOperatingSystemStep]
    public var credentialReadinessSteps: [KeelportOperatingSystemStep]
    public var authorizedReviewSteps: [KeelportOperatingSystemStep]
    public var azCompletionSteps: [KeelportOperatingSystemStep]
    public var certificationSystemSteps: [KeelportOperatingSystemStep]
    public var syncUpdateSteps: [KeelportOperatingSystemStep]
    public var recoveryAutoFixSteps: [KeelportOperatingSystemStep]
    public var insuranceLiabilitySteps: [KeelportOperatingSystemStep]
    public var massDistributionSteps: [KeelportOperatingSystemStep]
    public var paymentAutomationSteps: [KeelportOperatingSystemStep]
    public var legalRiskAutomationSteps: [KeelportOperatingSystemStep]
    public var wealthCashflowSteps: [KeelportOperatingSystemStep]
    public var relocationOperationsSteps: [KeelportOperatingSystemStep]
    public var partnerBrandSteps: [KeelportOperatingSystemStep]
    public var growthSchedule2027Steps: [KeelportOperatingSystemStep]
    public var chatGPTHandoffSteps: [KeelportOperatingSystemStep]
    public var farajLegalESignSteps: [KeelportOperatingSystemStep]
    public var lifetimeWorkArchiveSteps: [KeelportOperatingSystemStep]
    public var mediaTiers: [KeelportMediaTier]
    public var channelRoutes: [KeelportChannelRoute]
    public var helpTopics: [KeelportHelpTopic]
    public var includeAppStoreConnectChecklist: Bool
    public var includeAdultAndSubstanceSafety: Bool
    public var telecomSecuritySteps: [KeelportOperatingSystemStep]

    public init(
        name: String = "Keelport AR Infusion Cascade",
        focus: String,
        releaseDate: String = KeelportCascadePlan.defaultReleaseDate,
        categories: [KeelportMarketCategory] = KeelportMarketCategory.allCases,
        membershipPlans: [KeelportMembershipPlan] = KeelportCascadePlan.defaultMembershipPlans,
        productLineup: [KeelportProductLineupItem] = KeelportCascadePlan.defaultProductLineup,
        launchPlays: [KeelportLaunchPlay] = KeelportCascadePlan.defaultLaunchPlays,
        rolloutStages: [KeelportRolloutStage] = KeelportCascadePlan.defaultRolloutStages,
        featureServiceReleaseSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultFeatureServiceReleaseSteps,
        testingHowTos: [KeelportTestingHowTo] = KeelportCascadePlan.defaultTestingHowTos,
        approvalCheckpoints: [KeelportApprovalCheckpoint] = KeelportCascadePlan.defaultApprovalCheckpoints,
        successMetrics: [KeelportSuccessMetric] = KeelportCascadePlan.defaultSuccessMetrics,
        medicalTeamHandoffSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultMedicalTeamHandoffSteps,
        credentialReadinessSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultCredentialReadinessSteps,
        authorizedReviewSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultAuthorizedReviewSteps,
        azCompletionSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultAZCompletionSteps,
        certificationSystemSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultCertificationSystemSteps,
        syncUpdateSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultSyncUpdateSteps,
        recoveryAutoFixSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultRecoveryAutoFixSteps,
        insuranceLiabilitySteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultInsuranceLiabilitySteps,
        massDistributionSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultMassDistributionSteps,
        paymentAutomationSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultPaymentAutomationSteps,
        legalRiskAutomationSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultLegalRiskAutomationSteps,
        wealthCashflowSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultWealthCashflowSteps,
        relocationOperationsSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultRelocationOperationsSteps,
        partnerBrandSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultPartnerBrandSteps,
        growthSchedule2027Steps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultGrowthSchedule2027Steps,
        chatGPTHandoffSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultChatGPTHandoffSteps,
        farajLegalESignSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultFarajLegalESignSteps,
        lifetimeWorkArchiveSteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultLifetimeWorkArchiveSteps,
        mediaTiers: [KeelportMediaTier] = KeelportCascadePlan.defaultMediaTiers,
        channelRoutes: [KeelportChannelRoute] = KeelportCascadePlan.defaultChannelRoutes,
        helpTopics: [KeelportHelpTopic] = KeelportCascadePlan.defaultHelpTopics,
        includeAppStoreConnectChecklist: Bool = true,
        includeAdultAndSubstanceSafety: Bool = true,
        telecomSecuritySteps: [KeelportOperatingSystemStep] = KeelportCascadePlan.defaultTelecomSecuritySteps
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.focus = focus.trimmingCharacters(in: .whitespacesAndNewlines)
        self.releaseDate = releaseDate.trimmingCharacters(in: .whitespacesAndNewlines)
        self.categories = categories
        self.membershipPlans = membershipPlans
        self.productLineup = productLineup
        self.launchPlays = launchPlays
        self.rolloutStages = rolloutStages
        self.featureServiceReleaseSteps = featureServiceReleaseSteps
        self.testingHowTos = testingHowTos
        self.approvalCheckpoints = approvalCheckpoints
        self.successMetrics = successMetrics
        self.medicalTeamHandoffSteps = medicalTeamHandoffSteps
        self.credentialReadinessSteps = credentialReadinessSteps
        self.authorizedReviewSteps = authorizedReviewSteps
        self.azCompletionSteps = azCompletionSteps
        self.certificationSystemSteps = certificationSystemSteps
        self.syncUpdateSteps = syncUpdateSteps
        self.recoveryAutoFixSteps = recoveryAutoFixSteps
        self.insuranceLiabilitySteps = insuranceLiabilitySteps
        self.massDistributionSteps = massDistributionSteps
        self.paymentAutomationSteps = paymentAutomationSteps
        self.legalRiskAutomationSteps = legalRiskAutomationSteps
        self.wealthCashflowSteps = wealthCashflowSteps
        self.relocationOperationsSteps = relocationOperationsSteps
        self.partnerBrandSteps = partnerBrandSteps
        self.growthSchedule2027Steps = growthSchedule2027Steps
        self.chatGPTHandoffSteps = chatGPTHandoffSteps
        self.farajLegalESignSteps = farajLegalESignSteps
        self.lifetimeWorkArchiveSteps = lifetimeWorkArchiveSteps
        self.mediaTiers = mediaTiers
        self.channelRoutes = channelRoutes
        self.helpTopics = helpTopics
        self.includeAppStoreConnectChecklist = includeAppStoreConnectChecklist
        self.includeAdultAndSubstanceSafety = includeAdultAndSubstanceSafety
        self.telecomSecuritySteps = telecomSecuritySteps
    }

    public static let defaultReleaseDate = "2026-08-25"

    public static let defaultMembershipPlans: [KeelportMembershipPlan] = [
        KeelportMembershipPlan(
            name: "AR Infusion Starter",
            audience: "Founders, operators, caregivers, and service teams using reviewed non-clinical workflows.",
            promise: "Launch documents, assistant actions, safety gates, and help guides for early Keelport use.",
            includedAccess: [
                "Keelport cascade export",
                "Release date tracking",
                "Help tab and hamburger menu guidance",
                "Confidential channel checklist"
            ]
        ),
        KeelportMembershipPlan(
            name: "AR Infusion Medical Review",
            audience: "MD, RN, hospital, wellness, sports, recreation, and family health teams reviewing use cases.",
            promise: "Study-ready packets that separate product ideas from clinical claims and route evidence for licensed review.",
            includedAccess: [
                "Medical-team handoff workflow",
                "Quality-of-life measure planning",
                "Consent and privacy review prompts",
                "Adult wellness and harm-reduction safety gates"
            ]
        ),
        KeelportMembershipPlan(
            name: "AR Infusion Enterprise Cascade",
            audience: "Brands, service outlets, media teams, app teams, and hardware/software operators.",
            promise: "Step-up release planning across services, industries, brands, content, devices, and partner channels.",
            includedAccess: [
                "Feature and service release ladder",
                "MCP server routing packet",
                "App, bot, and software automation checklist",
                "Hardware update approval gates",
                "A-Z credential and authorized-review readiness packet"
            ]
        )
    ]

    public static let defaultProductLineup: [KeelportProductLineupItem] = [
        KeelportProductLineupItem(
            name: "Keelport MCP Server",
            launchRole: "Coordination backbone for release packets, channel routing, app automation events, and audit trails.",
            customer: "Internal operators, app teams, medical reviewers, brand partners, and approved service channels.",
            marketEdge: "One dated operating record for features, services, industries, brands, apps, bots, software, and hardware follow-up.",
            proofPoint: "Every routed item has a release date, owner, destination, confidentiality level, evidence field, and hard stop.",
            callToAction: "Queue AR Infusion work only after credentials, API permissions, and recipient authorization are confirmed."
        ),
        KeelportProductLineupItem(
            name: "AR Infusion Medical Study Board",
            launchRole: "Transforms AR use-case ideas into non-diagnostic study packets for qualified medical review.",
            customer: "MD, RN, hospital, wellness, sports medicine, family health, and research partners.",
            marketEdge: "Keeps quality-of-life goals measurable while blocking unreviewed clinical claims.",
            proofPoint: "Medical packets include intended population, workflow, measures, consent path, privacy review, and escalation owner.",
            callToAction: "Send only de-identified or authorized materials to medical channels for review."
        ),
        KeelportProductLineupItem(
            name: "Family Health and Wellness Relay",
            launchRole: "Organizes education, wellness, safety, recreation, and care-navigation content into reviewed channels.",
            customer: "Families, caregivers, wellness teams, community programs, and safety educators.",
            marketEdge: "Practical guidance stays separate from diagnosis, treatment, emergency care, and medical advice.",
            proofPoint: "Each content path lists reviewer, date, source standard, audience, and next step.",
            callToAction: "Publish only reviewed educational material with clear support and escalation routes."
        ),
        KeelportProductLineupItem(
            name: "Media Commerce Studio",
            launchRole: "Routes music, movie, commercial, brand, and product content through claim, rights, and safety review.",
            customer: "Creative teams, brands, distributors, advertisers, and product launch operators.",
            marketEdge: "Commercial output is tied to evidence, rights, disclosure, audience fit, and launch channel.",
            proofPoint: "Every asset records owner, usage rights, market, safety review, format, and delivery channel.",
            callToAction: "Package media assets for approved channels after rights and claims are checked."
        ),
        KeelportProductLineupItem(
            name: "Adult Wellness and Harm Reduction Safety Desk",
            launchRole: "Creates age-gated, consent-aware, safety-first review paths for adult wellness and substance harm-reduction topics.",
            customer: "Moderators, educators, compliance reviewers, wellness partners, and safety teams.",
            marketEdge: "Sensitive categories are handled with privacy, age gating, legal review, and human escalation.",
            proofPoint: "Blocked areas include illegal procurement, evasion, exploitative content, underage content, and medical-claim content.",
            callToAction: "Route uncertain cases to human review before publishing, monetizing, or automating."
        )
    ]

    public static let defaultLaunchPlays: [KeelportLaunchPlay] = [
        KeelportLaunchPlay(
            title: "Express Lightspeed Release Queue",
            channel: "Keelport MCP server, internal app queue, and approved partner channels.",
            action: "Group each feature, service, industry, and brand into a dated release packet with evidence and owner approval.",
            metric: "Release packet has date, owner, status, proof, channel, confidentiality, and next step."
        ),
        KeelportLaunchPlay(
            title: "Confidential Medical Review",
            channel: "Authorized MD, RN, hospital, research, and wellness review teams.",
            action: "Pass only scoped, minimum-necessary study materials and keep clinical decisions outside product automation.",
            metric: "Reviewer roster, consent path, privacy check, and clinical boundary are documented before pilot use."
        ),
        KeelportLaunchPlay(
            title: "Content and Commercial Distribution",
            channel: "Music, movie, commercial, brand, app, bot, and software release channels.",
            action: "Validate rights, claims, disclosure, safety copy, and launch destination before distribution.",
            metric: "No content ships without owner, rights, format, audience, review state, and withdrawal path."
        )
    ]

    public static let defaultRolloutStages: [KeelportRolloutStage] = [
        KeelportRolloutStage(
            title: "Stage 1 - Private Packet",
            scope: "Draft the AR Infusion use case, MCP server route, release date, owner, evidence, and hard stops.",
            trialAccess: "Internal owner and trusted technical reviewer only.",
            requiredProof: "Generated markdown, app build check, issue list, and credentials kept outside source control.",
            exitGate: "No external send until the channel, recipient, and confidentiality level are approved."
        ),
        KeelportRolloutStage(
            title: "Stage 2 - Medical and Safety Review",
            scope: "Route qualified health, wellness, harm-reduction, adult-wellness, sports, and recreation materials for review.",
            trialAccess: "Authorized reviewers with minimum-necessary information.",
            requiredProof: "Reviewer role, consent path, privacy review, study measure, and claim boundary are documented.",
            exitGate: "No medical-use claim, diagnosis, treatment guidance, or emergency instruction without licensed approval."
        ),
        KeelportRolloutStage(
            title: "Stage 3 - Service and Brand Pilot",
            scope: "Test app, bot, software, content, commercial, and hardware-adjacent workflows with approved partners.",
            trialAccess: "Named pilot users and channels.",
            requiredProof: "Feedback, logs, content rights, support path, refund path, and incident route are recorded.",
            exitGate: "No scale-up until support, billing, safety, privacy, and reliability gates pass."
        ),
        KeelportRolloutStage(
            title: "Stage 4 - Public Release",
            scope: "Release reviewed features, services, industries, brands, media, settings, and help workflows.",
            trialAccess: "Market-specific availability.",
            requiredProof: "Clean build, reviewed copy, active support route, rollback plan, and approval record.",
            exitGate: "Pause release on unresolved safety, legal, clinical, privacy, billing, or hardware risk."
        )
    ]

    public static let defaultFeatureServiceReleaseSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Feature intake",
            target: "Apps, bots, software, services, tools, settings, experiences, and content.",
            action: "Create a dated ticket with owner, audience, category, user value, dependency, and release channel.",
            evidence: "Ticket ID, markdown packet, app screen, or working prototype link.",
            hardStop: "Do not automate outside the app without credentials, API access, and explicit user authorization."
        ),
        KeelportOperatingSystemStep(
            name: "Industry and brand mapping",
            target: "Family health, wellness, sports, recreation, tech, travel, leisure, adult wellness, harm reduction, and safety education.",
            action: "Map each item to one primary category, one reviewer, one support path, and one launch channel.",
            evidence: "Category matrix with reviewer, channel, and launch-state columns.",
            hardStop: "Do not publish regulated, age-gated, or safety-sensitive material without review."
        ),
        KeelportOperatingSystemStep(
            name: "Step-up release train",
            target: "Private draft, reviewer pilot, service pilot, brand pilot, public release, and rollback.",
            action: "Move work forward only when the current gate has evidence and the next channel is approved.",
            evidence: "Release log with date, status, reviewer, risk note, and next step.",
            hardStop: "Any unresolved clinical, privacy, legal, billing, or safety issue blocks the next release step."
        ),
        KeelportOperatingSystemStep(
            name: "Hardware update handoff",
            target: "Devices, sensors, displays, AR equipment, and supporting components.",
            action: "Track firmware, operating system, accessory, and component updates as review tasks, not silent changes.",
            evidence: "Device inventory, version, owner approval, backup state, and rollback plan.",
            hardStop: "Do not update medical, safety, or business-critical hardware without authorization and backup."
        )
    ]

    public static let defaultTestingHowTos: [KeelportTestingHowTo] = [
        KeelportTestingHowTo(
            title: "Create the AR Infusion packet",
            target: "Keelport cascade markdown export.",
            steps: [
                "Open Launch.",
                "Choose Create AR Infusion Membership Cascade.",
                "Confirm the status message names Keelport_AR_Infusion_Cascade.md.",
                "Review date, release gate, medical handoff, channel route, and help sections."
            ],
            evidence: "Generated markdown file with release date 2026-08-25."
        ),
        KeelportTestingHowTo(
            title: "Route a medical review use case",
            target: "MD, RN, hospital, family health, wellness, sports, recreation, and safety review workflow.",
            steps: [
                "Describe the intended non-diagnostic workflow.",
                "Remove unnecessary personal health information.",
                "List proposed measures and reviewer roles.",
                "Send only through an authorized confidential channel."
            ],
            evidence: "Medical handoff packet with reviewer, consent, privacy, and claim-boundary fields."
        ),
        KeelportTestingHowTo(
            title: "Use the help and menu flow",
            target: "Help tab and AR Infusion hamburger menu.",
            steps: [
                "Open the Help tab for how-tos.",
                "Open AR Infusion.",
                "Use the top-right menu for help or cascade generation.",
                "Verify sensitive tasks remain behind authorization."
            ],
            evidence: "Help tab renders topics, channel routes, and hard stops."
        )
    ]

    public static let defaultApprovalCheckpoints: [KeelportApprovalCheckpoint] = [
        KeelportApprovalCheckpoint(
            name: "Clinical review",
            authority: "Licensed medical reviewer, research lead, or hospital approval owner.",
            trigger: "Any quality-of-life, health, wellness, recovery, patient, or clinical workflow claim.",
            action: "Confirm use-case boundary, measures, consent, privacy, escalation, and reviewer signoff.",
            evidence: "Signed review note, study protocol, or approval record stored outside source control."
        ),
        KeelportApprovalCheckpoint(
            name: "Privacy and consent",
            authority: "Privacy owner, counsel, compliance reviewer, or authorized data steward.",
            trigger: "Any personal, health, family, adult wellness, substance, safety, or account-sensitive information.",
            action: "Use minimum necessary data, de-identification where appropriate, consent records, and secure storage.",
            evidence: "Privacy review entry and consent path."
        ),
        KeelportApprovalCheckpoint(
            name: "Automation and hardware",
            authority: "Device owner, system administrator, or technical lead.",
            trigger: "Any app, bot, software, server, hardware, firmware, or component update.",
            action: "Verify access, backup, rollback, maintenance window, and human approval before running changes.",
            evidence: "Change record with owner, date, backup status, and rollback steps."
        )
    ]

    public static let defaultSuccessMetrics: [KeelportSuccessMetric] = [
        KeelportSuccessMetric(
            name: "Medical review readiness",
            measurement: "Percent of health-related packets with reviewer, measure, consent, privacy, and hard-stop fields complete.",
            healthySignal: "Medical teams can assess the use case without guessing intent, evidence, or boundaries.",
            integrityGuardrail: "Readiness is not proof of clinical benefit; benefit claims require qualified study and approval."
        ),
        KeelportSuccessMetric(
            name: "Quality-of-life study signal",
            measurement: "Validated measures selected by qualified reviewers for each approved pilot.",
            healthySignal: "The pilot can evaluate usability, access, safety, and quality-of-life outcomes consistently.",
            integrityGuardrail: "Do not advertise better health outcomes before evidence and review support the claim."
        ),
        KeelportSuccessMetric(
            name: "Release reliability",
            measurement: "Clean builds, successful exports, working assistant actions, and completed rollback plans per release.",
            healthySignal: "Users see clear status, support, and recovery paths.",
            integrityGuardrail: "Pause releases when provider access, billing, privacy, safety, or clinical gates are unresolved."
        ),
        KeelportSuccessMetric(
            name: "Content safety",
            measurement: "Percent of music, movie, commercial, adult, harm-reduction, and safety education assets with rights and review status.",
            healthySignal: "Approved channels receive complete assets with audience, rights, and moderation notes.",
            integrityGuardrail: "Block exploitative, unsafe, illegal, underage, or unreviewed medical-claim content."
        )
    ]

    public static let defaultMedicalTeamHandoffSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Medical use-case scope",
            target: "AR Infusion workflows proposed for MD, RN, hospital, family health, wellness, sports, recreation, and safety teams.",
            action: "Write the use case as education, coordination, measurement, or workflow support unless licensed review approves more.",
            evidence: "Scope statement with population, setting, measure, expected benefit hypothesis, and excluded claims.",
            hardStop: "No diagnosis, treatment, emergency guidance, or clinical benefit claim without qualified approval."
        ),
        KeelportOperatingSystemStep(
            name: "Measure selection",
            target: "Quality-of-life, access, usability, safety, adherence, satisfaction, and workflow measures.",
            action: "Ask medical reviewers to select validated measures and define how data is captured, protected, and interpreted.",
            evidence: "Measure list, collection method, reviewer, and analysis boundary.",
            hardStop: "Do not collect health data until consent, privacy, retention, and access rules are approved."
        ),
        KeelportOperatingSystemStep(
            name: "Clinical handoff packet",
            target: "MD, RN, hospital, wellness, harm-reduction, adult-wellness, and safety education outlets.",
            action: "Send a concise packet with date, purpose, reviewer request, minimum data, safety boundaries, and next decision.",
            evidence: "Recipient list, channel route, consent status, and follow-up task.",
            hardStop: "Do not send confidential or health information through unapproved channels."
        ),
        KeelportOperatingSystemStep(
            name: "Study review and escalation",
            target: "Medical teams, research leads, privacy owners, and support operators.",
            action: "Escalate human-subject research, adverse events, sensitive cases, and unclear medical claims to qualified review.",
            evidence: "Escalation log with date, owner, decision, and required action.",
            hardStop: "Stop the pilot on unresolved safety events, privacy incidents, or unsupported health claims."
        )
    ]

    public static let defaultCredentialReadinessSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Credential inventory",
            target: "Apple Developer, App Store Connect, OpenAI, Keelport MCP server, email, domain, hosting, database, payment, analytics, storage, CI, social, media, carrier, VoIP, and hardware-vendor accounts.",
            action: "Create a credential inventory with service name, owner, access role, MFA state, rotation date, recovery route, and secret-manager location only.",
            evidence: "Inventory record with placeholders such as password-manager item name or provider portal link; no passwords, private keys, tokens, recovery codes, or seed phrases.",
            hardStop: "Never store secrets in source code, markdown exports, screenshots, chat, logs, or issue trackers."
        ),
        KeelportOperatingSystemStep(
            name: "Access proof",
            target: "Official provider portals and admin consoles.",
            action: "Confirm each account can sign in from a trusted device, has MFA, has the right owner, and has unknown sessions, OAuth grants, API keys, and app passwords reviewed.",
            evidence: "Dated checklist with provider, role, last verified date, and reviewer initials.",
            hardStop: "Do not run automation or connect APIs until access proof and permissions are complete."
        ),
        KeelportOperatingSystemStep(
            name: "Secret manager setup",
            target: "Password manager, CI secret store, cloud secret manager, and local development environment.",
            action: "Move secrets into official vaults with named items, scoped access, rotation schedule, and emergency recovery owner.",
            evidence: "Vault item names and access policy references, not secret values.",
            hardStop: "Any exposed or unknown secret must be revoked and rotated before release."
        ),
        KeelportOperatingSystemStep(
            name: "API permission map",
            target: "App, bot, server, payment, email, storage, content, analytics, medical-review, and hardware-adjacent integrations.",
            action: "Map each integration to read/write scope, data touched, user consent, rate limits, audit logging, and rollback behavior.",
            evidence: "Integration matrix with least-privilege scopes and approval owner.",
            hardStop: "No write-capable integration runs without explicit owner approval and rollback."
        )
    ]

    public static let defaultAuthorizedReviewSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Medical review authorization",
            target: "MD, RN, hospital, research, wellness, sports, recreation, family health, adult wellness, substance harm-reduction, and safety education use cases.",
            action: "Assign qualified reviewers, define review authority, confirm consent and privacy path, and mark claim boundaries before any study or pilot.",
            evidence: "Reviewer roster, role, approval date, study boundary, and escalation contact.",
            hardStop: "No diagnosis, treatment, emergency, clinical benefit, or patient-care claim without licensed approval."
        ),
        KeelportOperatingSystemStep(
            name: "Legal and compliance review",
            target: "Terms, privacy policy, contracts, eSign, liability, advertising claims, regulated content, adult wellness, substance topics, and partner distribution.",
            action: "Route final language and workflows to counsel or qualified compliance reviewer before public or partner release.",
            evidence: "Reviewed copy, approval note, signed agreement, or compliance decision record.",
            hardStop: "Unreviewed regulated, legal, or contractual work stays internal."
        ),
        KeelportOperatingSystemStep(
            name: "Security and privacy review",
            target: "Personal data, health context, family information, payment data, location, device identifiers, logs, analytics, and account recovery data.",
            action: "Confirm data minimization, retention, encryption, deletion path, incident route, and access controls.",
            evidence: "Privacy checklist, threat model, data map, and incident owner.",
            hardStop: "Do not collect or send sensitive data without consent, purpose, and secure storage."
        ),
        KeelportOperatingSystemStep(
            name: "Commercial and rights review",
            target: "Music, movie, commercial, brand, product, service, travel, leisure, sports, recreation, tech, and media releases.",
            action: "Verify rights, claims, pricing, refunds, tax handling, disclosures, age gates, support route, and channel permissions.",
            evidence: "Rights log, claim review, price sheet, support route, and approval record.",
            hardStop: "Do not publish content or charge customers without rights, terms, and support readiness."
        )
    ]

    public static let defaultAZCompletionSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "A - Access",
            target: "All required accounts and provider portals.",
            action: "Verify owner access, MFA, recovery, secret-manager reference, and admin role.",
            evidence: "Credential inventory row for every account.",
            hardStop: "Missing access blocks automation and release."
        ),
        KeelportOperatingSystemStep(
            name: "B - Build",
            target: "Xcode app, documents, assistant actions, server-adjacent workflows, and exports.",
            action: "Run a clean build and confirm generated documents include release date, credentials readiness, authorized review, and A-Z completion sections.",
            evidence: "Build result and generated markdown.",
            hardStop: "No release with build errors or broken exports."
        ),
        KeelportOperatingSystemStep(
            name: "C - Credentials",
            target: "Secrets, API keys, certificates, provisioning profiles, tokens, OAuth apps, webhooks, and device credentials.",
            action: "Place every secret in a vault, rotate exposed values, and keep only references in code or documents.",
            evidence: "Vault reference, rotation date, and owner.",
            hardStop: "Exposed, unknown, or unrotated secrets block release."
        ),
        KeelportOperatingSystemStep(
            name: "D - Decisions",
            target: "Medical, legal, privacy, security, payments, hardware, media, app store, and partner launch decisions.",
            action: "Record who can approve, what they approved, what they rejected, and the next action.",
            evidence: "Decision log with approver, date, scope, and evidence.",
            hardStop: "No assumed approval."
        ),
        KeelportOperatingSystemStep(
            name: "E - Export",
            target: "Keelport cascade, legal handoff, telecom cascade, invoices, release packets, and partner packets.",
            action: "Export only the approved packet for the intended channel and mark confidentiality.",
            evidence: "Exported file name, channel, recipient, and approval state.",
            hardStop: "Do not export secrets, protected health information, or confidential partner data into public materials."
        ),
        KeelportOperatingSystemStep(
            name: "Z - Zero unresolved blockers",
            target: "Final release, pilot, or handoff.",
            action: "Confirm every critical blocker has owner, status, mitigation, and signoff before sending, launching, or automating.",
            evidence: "Final readiness checklist with no open release-blocking items.",
            hardStop: "Any unresolved safety, medical, privacy, legal, payment, access, or hardware blocker pauses release."
        )
    ]

    public static let defaultCertificationSystemSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Inventory certification",
            target: "Apps, bots, software, services, hardware, content, settings, and channels.",
            action: "List every component with owner, version, release date, data touched, and approval owner.",
            evidence: "Component inventory attached to the release packet.",
            hardStop: "Unknown ownership or missing approval blocks certification."
        ),
        KeelportOperatingSystemStep(
            name: "Evidence certification",
            target: "Claims, screenshots, builds, exports, invoices, assistant actions, and media assets.",
            action: "Attach proof before claims move into public, partner, medical, or commercial channels.",
            evidence: "Proof folder, generated document, build result, or signed review.",
            hardStop: "Unverified claims stay internal."
        )
    ]

    public static let defaultSyncUpdateSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Software sync",
            target: "iOS, macOS, app targets, bots, server jobs, and support scripts.",
            action: "Track current version, update needed, owner, test path, and rollback before sync.",
            evidence: "Version log and build result.",
            hardStop: "Do not run destructive updates or account changes without authorization."
        ),
        KeelportOperatingSystemStep(
            name: "Hardware sync",
            target: "Phones, Macs, AR devices, accessories, sensors, and service components.",
            action: "Confirm backup, power, network, maintenance window, and owner approval before update.",
            evidence: "Device checklist and post-update verification.",
            hardStop: "Stop when the device is managed, medically used, safety-critical, or missing backup."
        )
    ]

    public static let defaultRecoveryAutoFixSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Provider recovery",
            target: "Apple, email, carrier, VoIP, domains, banking, app stores, and connected platforms.",
            action: "Create official support cases, rotate credentials from trusted devices, and remove unknown sessions.",
            evidence: "Provider case IDs and trusted-device checklist stored securely outside source control.",
            hardStop: "Do not store passwords, keys, recovery codes, or private phone data in the repository."
        ),
        KeelportOperatingSystemStep(
            name: "Auto-fix boundary",
            target: "Scripts, bots, assistants, and server automation.",
            action: "Use automation for reminders, exports, and checklists until provider APIs and credentials are verified.",
            evidence: "Automation permission record.",
            hardStop: "No automatic account, payment, carrier, or device changes without explicit owner approval."
        )
    ]

    public static let defaultInsuranceLiabilitySteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Liability intake",
            target: "Medical, adult wellness, substance harm-reduction, travel, recreation, hardware, and commercial services.",
            action: "Document risk type, audience, jurisdiction, reviewer, coverage question, and required disclaimer.",
            evidence: "Risk intake packet.",
            hardStop: "Do not launch high-risk services before legal, insurance, and safety review."
        )
    ]

    public static let defaultMassDistributionSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Channel approval",
            target: "App stores, web, email, partners, social, media, hospitals, wellness outlets, and brand channels.",
            action: "Confirm recipient permission, content rights, privacy level, support route, and withdrawal path.",
            evidence: "Distribution checklist.",
            hardStop: "No confidential, medical, adult, or account-sensitive materials go to public channels."
        )
    ]

    public static let defaultPaymentAutomationSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Payment gate",
            target: "Subscriptions, invoices, refunds, partner payouts, and commerce flows.",
            action: "Keep payment terms, taxes, refund rules, and customer support visible before charging.",
            evidence: "Invoice, product ID, or payment provider record.",
            hardStop: "Do not move money without configured provider access, customer consent, and legal review where required."
        )
    ]

    public static let defaultLegalRiskAutomationSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Legal claim review",
            target: "Medical, wellness, adult, harm-reduction, safety, finance, travel, hardware, and commercial claims.",
            action: "Route claims to counsel or qualified reviewer before public use.",
            evidence: "Review note, approval record, or marked revision.",
            hardStop: "Unsupported claims cannot be published or automated."
        )
    ]

    public static let defaultWealthCashflowSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Cashflow ledger",
            target: "Memberships, services, tools, media, commercial work, and partner brand deals.",
            action: "Track source, price, cost, tax question, payout route, owner, and fulfillment status.",
            evidence: "Finance hub entry or invoice.",
            hardStop: "No financial advice, investment claims, or money movement without qualified review and provider setup."
        )
    ]

    public static let defaultRelocationOperationsSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Multi-base operations",
            target: "Travel, leisure, family health, work sites, wellness outlets, sports, recreation, and support locations.",
            action: "Track location, access, equipment, connectivity, emergency contact, and privacy constraints.",
            evidence: "Operations checklist.",
            hardStop: "Do not route health, account, or safety-sensitive work to unmanaged locations."
        )
    ]

    public static let defaultPartnerBrandSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Partner brand workboard",
            target: "Brands, services, industries, media partners, medical outlets, and education channels.",
            action: "Create a workboard item with partner, offer, claim boundary, asset needs, owner, and approval path.",
            evidence: "Partner brief or workboard entry.",
            hardStop: "No partner handoff without confidentiality, rights, scope, and recipient authorization."
        )
    ]

    public static let defaultGrowthSchedule2027Steps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "2027 step-up schedule",
            target: "Feature releases, services, industries, brands, medical pilots, media, and hardware reviews.",
            action: "Schedule quarterly gates for review, pilot, support, scale, and rollback.",
            evidence: "Roadmap entry with quarter, owner, status, and risk gate.",
            hardStop: "Scale-up waits until the current release has evidence and support coverage."
        )
    ]

    public static let defaultChatGPTHandoffSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Assistant handoff",
            target: "ChatGPT, Phoenix Assistant, app tools, bots, and MCP-adjacent automation.",
            action: "Describe task, data allowed, action limits, output format, and required human approval.",
            evidence: "Assistant handoff note.",
            hardStop: "Do not grant assistants unreviewed authority over accounts, payments, hardware, or clinical decisions."
        )
    ]

    public static let defaultFarajLegalESignSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Legal eSign packet",
            target: "Faraj Law, Faraj Legal, partners, reviewers, and authorized signers.",
            action: "Prepare scope, parties, terms, consent to electronic records, signer authority, and audit trail.",
            evidence: "Draft packet ready for legal review.",
            hardStop: "This app does not execute contracts or provide legal advice."
        )
    ]

    public static let defaultLifetimeWorkArchiveSteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "A-Z archive",
            target: "Documents, releases, medical packets, content, media, invoices, hardware logs, and partner work.",
            action: "Archive with date, owner, category, confidentiality, source, and next action.",
            evidence: "Indexed archive entry.",
            hardStop: "Do not archive secrets, passwords, private keys, or unauthorized health information in source control."
        )
    ]

    public static let defaultTelecomSecuritySteps: [KeelportOperatingSystemStep] = [
        KeelportOperatingSystemStep(
            name: "Carrier security review",
            target: "Phone, VoIP, SMS, call forwarding, SIM swap, recovery numbers, and account PINs.",
            action: "Use official provider portals to review devices, routing, forwarding, port freeze, and fraud case status.",
            evidence: "Provider case number and trusted-device verification kept securely.",
            hardStop: "Do not publish private numbers, recovery routes, or provider credentials."
        )
    ]

    public static let defaultMediaTiers: [KeelportMediaTier] = [
        KeelportMediaTier(
            name: "Review Draft",
            photoTarget: "Source images and screenshots with owner and rights noted",
            videoTarget: "Rough cuts and screen recordings with audience and claim notes",
            validationGate: "Internal review only"
        ),
        KeelportMediaTier(
            name: "Commercial Ready",
            photoTarget: "Final export with rights, disclosure, and placement confirmed",
            videoTarget: "Final cut with captions, audio rights, claim review, and channel format",
            validationGate: "Owner, rights, safety, and channel approval"
        )
    ]

    public static let defaultChannelRoutes: [KeelportChannelRoute] = [
        KeelportChannelRoute(
            name: "Express Lightspeed Internal",
            destination: "Keelport MCP server release queue and internal app workboard.",
            confidentiality: "Confidential owner-only until the channel and recipient are approved.",
            payload: "Release date, feature, service, brand, category, owner, evidence, risk gate, and next step.",
            approvalGate: "Owner approval, clean build, and no unresolved safety, privacy, clinical, legal, or billing risk."
        ),
        KeelportChannelRoute(
            name: "Medical Review",
            destination: "Authorized MD, RN, hospital, research, wellness, sports, recreation, and safety education teams.",
            confidentiality: "Minimum necessary data; de-identified or consented health context only.",
            payload: "Use case, target population, workflow, proposed measures, privacy path, consent state, and hard stops.",
            approvalGate: "Licensed review and privacy approval before study, pilot, or health-related claim."
        ),
        KeelportChannelRoute(
            name: "Brand and Media Distribution",
            destination: "Approved music, movie, commercial, app, bot, software, partner, and public channels.",
            confidentiality: "Public only after rights, claim, disclosure, and audience checks pass.",
            payload: "Asset list, rights owner, format, campaign, approved copy, support path, and rollback note.",
            approvalGate: "Rights, safety, moderation, and commercial claim approval."
        ),
        KeelportChannelRoute(
            name: "Hardware and Component Updates",
            destination: "Device owner, technical lead, authorized service provider, or support ticket.",
            confidentiality: "Private inventory and configuration data.",
            payload: "Device, component, version, backup state, update request, test path, and rollback plan.",
            approvalGate: "Owner authorization, backup, maintenance window, and no medical or safety-critical conflict."
        )
    ]

    public static let defaultHelpTopics: [KeelportHelpTopic] = [
        KeelportHelpTopic(
            title: "Next Steps",
            summary: "Turn broad AR Infusion work into dated release packets that can be reviewed and routed.",
            steps: [
                "Create or update the Keelport cascade.",
                "Pick one category, owner, channel, and reviewer for each item.",
                "Attach evidence and a rollback plan.",
                "Move to medical, brand, service, or public channels only after the gate passes."
            ],
            escalation: "Pause and ask for qualified review when the item involves health, safety, payments, legal terms, adult content, substances, or hardware changes."
        ),
        KeelportHelpTopic(
            title: "Medical Handoff",
            summary: "Prepare AR use cases for medical teams without making unsupported clinical claims.",
            steps: [
                "Write the use case in plain language.",
                "List the target setting and proposed quality-of-life measure.",
                "Remove unnecessary personal health information.",
                "Send through the approved medical review channel."
            ],
            escalation: "Licensed review is required before diagnosis, treatment, emergency guidance, or health-benefit claims."
        ),
        KeelportHelpTopic(
            title: "Server and Automation",
            summary: "Use the MCP server route as a work queue and audit trail until live provider integrations are configured.",
            steps: [
                "Confirm the destination app, bot, server job, or hardware item.",
                "Check credentials and permissions outside source control.",
                "Run a small test with logs and rollback.",
                "Record the outcome in the release packet."
            ],
            escalation: "Do not let automation change accounts, devices, payments, or clinical workflows without explicit owner approval."
        ),
        KeelportHelpTopic(
            title: "Confidential Channels",
            summary: "Keep sensitive work private until recipient, purpose, and channel are verified.",
            steps: [
                "Mark each packet public, partner, medical, legal, or owner-only.",
                "Use minimum necessary information.",
                "Record who received it and why.",
                "Keep withdrawal and correction steps available."
            ],
            escalation: "Use secure review before sending health, account, legal, adult, substance, or hardware-sensitive data."
        )
    ]
    
    public func markdown(bodyOnly: Bool = false) -> String {
        var lines: [String] = [
            "# \(name)",
            "",
            "Keelport MCP Server Date: \(releaseDate.isEmpty ? Self.defaultReleaseDate : releaseDate)",
            "",
            "Focus: \(focus.isEmpty ? "AR Infusion membership, product cascade, media quality, and AI safety" : focus)",
            "",
            "## Run Destination",
            "- Use Fastlane lane `build_keelport` or `xcodebuild` with `XCODE_DESTINATION` set.",
            "- Default automation builds against `generic/platform=iOS Simulator` so it does not depend on the Xcode UI selected destination.",
            "- Use `generic/platform=iOS` for physical-device archive/build checks when signing is configured.",
            "- If simulator runtime services are unavailable, build-only verification can still run with a generic destination.",
            "",
            "## Keelport MCP Server Release Packet",
            "- Date: \(releaseDate.isEmpty ? Self.defaultReleaseDate : releaseDate).",
            "- Purpose: queue AR Infusion features, services, industries, brands, medical-review packets, content, software, bots, apps, and hardware follow-up through one auditable route.",
            "- Scope: this document prepares work for authorized systems; it does not by itself run external servers, change hardware, send confidential material, or make clinical decisions.",
            "",
            "## AR Infusion Membership Category",
            "- AR Infusion is positioned as a new Bassam S Faraj Jr invention category: spatial software, accountable assistants, device-aware media, and hardware-ready workflows that move beyond passive AI into verified action.",
            "- Permanent owner standard: this source-controlled cascade belongs to Bassam S Faraj Jr as the operating record for AR Infusion product, app, software, hardware, trial, approval, and integrity planning.",
            "- The category is inspired by the product discipline of Steve Jobs, the platform reach of Bill Gates, the engineering craft of Steve Wozniak, the computing foundations of Grace Hopper, and the learning vision of Alan Kay.",
            "- Memberships are monthly by default, with final App Store Connect product IDs, prices, market availability, trial rules, and tax handling configured outside source control.",
            "",
            "## Launch Product Lineup"
        ]

        for item in productLineup {
            lines.append("- \(item.name): \(item.launchRole). Customer: \(item.customer). Edge: \(item.marketEdge). Proof: \(item.proofPoint). CTA: \(item.callToAction).")
        }

        lines.append(contentsOf: [
            "",
            "## Competitive Launch Plays"
        ])

        for play in launchPlays {
            lines.append("- \(play.title): \(play.action) Channel: \(play.channel). Measure: \(play.metric).")
        }

        lines.append(contentsOf: [
            "",
            "## Rollout Form"
        ])

        for stage in rolloutStages {
            lines.append("- \(stage.title): \(stage.scope). Trial access: \(stage.trialAccess). Proof: \(stage.requiredProof). Exit gate: \(stage.exitGate).")
        }

        appendOperatingSystemSection("Feature Service Industry Brand Release Engine", featureServiceReleaseSteps, to: &lines)

        lines.append(contentsOf: [
            "",
            "## Testing and Development How-Tos"
        ])

        for item in testingHowTos {
            lines.append("- \(item.title): Target: \(item.target). Steps: \(item.steps.joined(separator: " ")) Evidence: \(item.evidence).")
        }

        lines.append(contentsOf: [
            "",
            "## Approval Checkpoints"
        ])

        for checkpoint in approvalCheckpoints {
            lines.append("- \(checkpoint.name): Authority: \(checkpoint.authority). Trigger: \(checkpoint.trigger). Action: \(checkpoint.action) Evidence: \(checkpoint.evidence).")
        }

        lines.append(contentsOf: [
            "",
            "## Measures of Success"
        ])

        for metric in successMetrics {
            lines.append("- \(metric.name): Measure: \(metric.measurement). Healthy signal: \(metric.healthySignal). Integrity guardrail: \(metric.integrityGuardrail).")
        }

        appendOperatingSystemSection("Medical Team Handoff and Study Use Case", medicalTeamHandoffSteps, to: &lines)
        appendOperatingSystemSection("Credential and Access Readiness", credentialReadinessSteps, to: &lines)
        appendOperatingSystemSection("Authorized Review Readiness", authorizedReviewSteps, to: &lines)
        appendOperatingSystemSection("A-Z Completion Runbook", azCompletionSteps, to: &lines)
        appendOperatingSystemSection("Certified Operating System", certificationSystemSteps, to: &lines)
        appendOperatingSystemSection("Current Hardware Software Service Sync", syncUpdateSteps, to: &lines)
        appendOperatingSystemSection("Recovery Auto-Fix Protocol", recoveryAutoFixSteps, to: &lines)
        appendOperatingSystemSection("Insurance and Liability Request Track", insuranceLiabilitySteps, to: &lines)
        appendOperatingSystemSection("Mass Distribution Controls", massDistributionSteps, to: &lines)
        appendOperatingSystemSection("Payment Automation Controls", paymentAutomationSteps, to: &lines)
        appendOperatingSystemSection("Legal and Risk Automation", legalRiskAutomationSteps, to: &lines)
        appendOperatingSystemSection("Wealth and Cashflow System", wealthCashflowSteps, to: &lines)
        appendOperatingSystemSection("Multi-Base Relocation Operations", relocationOperationsSteps, to: &lines)
        appendOperatingSystemSection("Partner Brand Empire Workboard", partnerBrandSteps, to: &lines)
        appendOperatingSystemSection("2027 Growth Schedule", growthSchedule2027Steps, to: &lines)
        appendOperatingSystemSection("ChatGPT Transfer Handoff", chatGPTHandoffSteps, to: &lines)
        appendOperatingSystemSection("Faraj Law Faraj Legal eSign Handoff", farajLegalESignSteps, to: &lines)
        appendOperatingSystemSection("A-Z Lifetime Work Archive", lifetimeWorkArchiveSteps, to: &lines)
        appendOperatingSystemSection("Telecom Security and Justice Protocol", telecomSecuritySteps, to: &lines)

        lines.append(contentsOf: [
            "",
            "## Monthly Memberships"
        ])

        for plan in membershipPlans {
            lines.append("- \(plan.name) (\(plan.cadence)): \(plan.promise) Audience: \(plan.audience). Includes: \(plan.includedAccess.joined(separator: "; ")).")
        }

        lines.append(contentsOf: [
            "",
            "## AR Infusion Assistants",
            "- Start with document, launch, billing, security, media, and moderation assistants.",
            "- Keep AR assistants grounded in local app state and explicit user actions.",
            "- Do not let assistants claim provider, carrier, email, Apple, or App Store Connect access unless credentials and APIs are connected.",
            "- Separate customer-facing AR experience from private account recovery and partner data.",
            "",
            "## Market Cascade"
        ])

        lines.append(contentsOf: categories.map { "- \($0.title): localize offers, safety copy, access, pricing, media format, and support path market by market." })

        lines.append(contentsOf: [
            "",
            "## Media Standard"
        ])
        for tier in mediaTiers {
            lines.append("- \(tier.name): \(tier.photoTarget); \(tier.videoTarget). Gate: \(tier.validationGate)")
        }

        appendChannelRouteSection("Confidential Channel Routing", channelRoutes, to: &lines)
        appendHelpTopicSection("Help Tab and Hamburger Menu How-Tos", helpTopics, to: &lines)

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

    public func legalHandoffMarkdown(bodyOnly: Bool = false) -> String {
        var lines: [String] = [
            "# ChatGPT Faraj Legal eSign Handoff",
            "",
            "Owner: Bassam S Faraj Jr",
            "Status: Draft handoff packet pending authorized delivery, legal review, e-sign setup, and signer consent.",
            "",
            "## Handoff Rules",
            "- This packet prepares work for review. It does not execute a contract, create legal advice, bind insurance, move money, or transfer ownership by itself.",
            "- External delivery requires the correct account, recipient, authorization, audit trail, and final human approval.",
            "- eSign execution requires signer identity, intent, authority, consent to electronic records, and any required witness or notary formalities."
        ]

        appendOperatingSystemSection("ChatGPT Intake", chatGPTHandoffSteps, to: &lines)
        appendOperatingSystemSection("Faraj Law and Faraj Legal", farajLegalESignSteps, to: &lines)
        appendOperatingSystemSection("A-Z Lifetime Work Archive", lifetimeWorkArchiveSteps, to: &lines)
        appendOperatingSystemSection("Legal and Risk Automation", legalRiskAutomationSteps, to: &lines)
        appendOperatingSystemSection("Payment Automation Controls", paymentAutomationSteps, to: &lines)
        appendOperatingSystemSection("Insurance and Liability Request Track", insuranceLiabilitySteps, to: &lines)

        let body = lines.joined(separator: "\n")
        if bodyOnly {
            return body
        }

        let letterhead = Letterhead(
            style: BrandPalette.founderPersonal,
            kind: .confidential,
            subtitle: "ChatGPT Faraj Legal eSign Handoff",
            disclaimer: "Draft routing packet. Legal, insurance, financial, e-sign, and third-party delivery actions require authorized review and execution outside this source file."
        )
        return DocumentBranding.prependLetterhead(body, letterhead: letterhead)
    }

    fileprivate func appendOperatingSystemSection(
        _ title: String,
        _ steps: [KeelportOperatingSystemStep],
        to lines: inout [String]
    ) {
        lines.append(contentsOf: ["", "## \(title)"])
        for step in steps {
            lines.append("- \(step.name): Target: \(step.target). Action: \(step.action) Evidence: \(step.evidence). Hard stop: \(step.hardStop)")
        }
    }

    private func appendChannelRouteSection(
        _ title: String,
        _ routes: [KeelportChannelRoute],
        to lines: inout [String]
    ) {
        lines.append(contentsOf: ["", "## \(title)"])
        for route in routes {
            lines.append("- \(route.name): Destination: \(route.destination) Confidentiality: \(route.confidentiality) Payload: \(route.payload) Approval gate: \(route.approvalGate)")
        }
    }

    private func appendHelpTopicSection(
        _ title: String,
        _ topics: [KeelportHelpTopic],
        to lines: inout [String]
    ) {
        lines.append(contentsOf: ["", "## \(title)"])
        for topic in topics {
            lines.append("- \(topic.title): \(topic.summary) Steps: \(topic.steps.joined(separator: " ")) Escalation: \(topic.escalation)")
        }
    }
}

public enum KeelportCascadeGenerator {
    @discardableResult
    public static func write(
        to directory: URL,
        focus: String = "AR Infusion membership, product cascade, media quality, and AI safety",
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

    @discardableResult
    public static func writeLegalHandoff(
        to directory: URL,
        focus: String = "ChatGPT, Faraj Law, Faraj Legal, eSign, and A-Z lifetime work handoff",
        bodyOnly: Bool = false
    ) throws -> URL {
        let plan = KeelportCascadePlan(focus: focus)
        let content = plan.legalHandoffMarkdown(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("ChatGPT_Faraj_Legal_eSign_Handoff.md")
        try Data(content.utf8).write(to: url)
        return url
    }
    
    @discardableResult
    public static func writeTelecomCascade(
        to directory: URL,
        bodyOnly: Bool = false
    ) throws -> URL {
        let plan = KeelportCascadePlan(focus: "Cellular Justice OS Telecom Accountability, Security, and Justice")
        
        var lines: [String] = [
            "# Cellular Justice OS",
            "",
            "Urgent call-to-action: Telecom accountability, security, and justice are critical in a connected world. This cascade outlines the essential protocols and standards to ensure secure, sovereign, and resilient mobile and emergency communication services.",
            ""
        ]
        
        // Find the Cellular Justice OS product lineup item (only one)
        if let cellularJusticeItem = plan.productLineup.first(where: { $0.name == "Cellular Justice OS" }) {
            lines.append("- \(cellularJusticeItem.name): \(cellularJusticeItem.launchRole). Customer: \(cellularJusticeItem.customer). Edge: \(cellularJusticeItem.marketEdge). Proof: \(cellularJusticeItem.proofPoint). CTA: \(cellularJusticeItem.callToAction).")
            lines.append("")
        }
        
        // Append Telecom Security and Justice Protocol section only
        plan.appendOperatingSystemSection("Telecom Security and Justice Protocol", plan.telecomSecuritySteps, to: &lines)
        
        lines.append(contentsOf: [
            "",
            "This cascade invites audit, reporting, and implementation by carriers, regulators, and the public to ensure a secure and just telecom ecosystem."
        ])
        
        let body = lines.joined(separator: "\n")
        let letterhead = Letterhead(
            style: BrandPalette.founderPersonal,
            kind: .program,
            subtitle: "Cellular Justice OS Cascade",
            disclaimer: "This document is a call-to-action for telecom security and justice protocols. Implementation and oversight require authorized cooperation among carriers, regulators, and users."
        )
        let content = bodyOnly ? body : DocumentBranding.prependLetterhead(body, letterhead: letterhead)
        let url = directory.appendingPathComponent("Cellular_Justice_OS_Cascade.md")
        try Data(content.utf8).write(to: url)
        return url
    }
}
