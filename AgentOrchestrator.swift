import Foundation

public enum LaunchActionPhase: String, CaseIterable, Codable, Sendable {
    case prepare
    case activate
    case prove
    case close
    case readout

    public var title: String {
        switch self {
        case .prepare: return "Prepare"
        case .activate: return "Activate"
        case .prove: return "Prove"
        case .close: return "Close"
        case .readout: return "Readout"
        }
    }
}

private extension String {
    var launchSentence: String {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        guard let last = trimmed.last else { return trimmed }
        if ".!?".contains(last) {
            return trimmed
        }
        return "\(trimmed)."
    }
}

public struct LaunchAction: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { "\(dueDay)-\(ownerTitle)-\(task)" }
    public var dueDay: Int
    public var phase: LaunchActionPhase
    public var ownerTitle: String
    public var task: String
    public var proof: String

    public init(dueDay: Int, phase: LaunchActionPhase, ownerTitle: String, task: String, proof: String) {
        self.dueDay = max(0, dueDay)
        self.phase = phase
        self.ownerTitle = ownerTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.task = task.trimmingCharacters(in: .whitespacesAndNewlines)
        self.proof = proof.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct LaunchWorkstream: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { name }
    public var name: String
    public var ownerTitle: String
    public var goal: String
    public var operatingRule: String

    public init(name: String, ownerTitle: String, goal: String, operatingRule: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.ownerTitle = ownerTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.goal = goal.trimmingCharacters(in: .whitespacesAndNewlines)
        self.operatingRule = operatingRule.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct OwnerBriefing: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { ownerTitle }
    public var ownerTitle: String
    public var mission: String
    public var dailyActions: [String]
    public var handoff: String

    public init(ownerTitle: String, mission: String, dailyActions: [String], handoff: String) {
        self.ownerTitle = ownerTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.mission = mission.trimmingCharacters(in: .whitespacesAndNewlines)
        self.dailyActions = dailyActions.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        self.handoff = handoff.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct OrchestratedLaunchPacket: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { "\(gameplan.id)-\(kickoffDate.timeIntervalSince1970)" }
    public var gameplan: Gameplan
    public var kickoffDate: Date
    public var workstreams: [LaunchWorkstream]
    public var ownerBriefings: [OwnerBriefing]
    public var dailyStandupPrompts: [String]
    public var actionQueue: [LaunchAction]
    public var readinessWarnings: [String]

    public init(
        gameplan: Gameplan,
        kickoffDate: Date,
        workstreams: [LaunchWorkstream],
        ownerBriefings: [OwnerBriefing],
        dailyStandupPrompts: [String],
        actionQueue: [LaunchAction],
        readinessWarnings: [String]
    ) {
        self.gameplan = gameplan
        self.kickoffDate = kickoffDate
        self.workstreams = workstreams
        self.ownerBriefings = ownerBriefings
        self.dailyStandupPrompts = dailyStandupPrompts
        self.actionQueue = actionQueue.sorted {
            if $0.dueDay == $1.dueDay {
                return $0.ownerTitle < $1.ownerTitle
            }
            return $0.dueDay < $1.dueDay
        }
        self.readinessWarnings = readinessWarnings
    }

    public var diamondShineScore: Int {
        AgentOrchestrator.diamondShineScore(for: self)
    }

    public func actions(for ownerTitle: String) -> [LaunchAction] {
        let needle = ownerTitle.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return actionQueue.filter { $0.ownerTitle.lowercased().contains(needle) }
    }

    public func markdown() -> String {
        let date = ISO8601DateFormatter().string(from: kickoffDate)
        var lines: [String] = [
            "# \(gameplan.title)",
            "",
            "Season: \(gameplan.season)",
            "Kickoff: \(date)",
            "Priority: \(gameplan.priority.title)",
            "Audience: \(gameplan.primaryAudience)",
            "",
            "## Objective",
            gameplan.objective,
            "",
            "## Diamond Shine Standard",
            gameplan.diamondShineDefinition,
            "",
            "## Score",
            "\(diamondShineScore)/100 launch readiness",
            ""
        ]

        if !readinessWarnings.isEmpty {
            lines.append("## Readiness Warnings")
            lines.append(contentsOf: readinessWarnings.map { "- \($0)" })
            lines.append("")
        }

        lines.append("## Workstreams")
        for stream in workstreams {
            lines.append("- \(stream.name): Owner: \(stream.ownerTitle). Goal: \(stream.goal.launchSentence) Rule: \(stream.operatingRule.launchSentence)")
        }

        lines.append(contentsOf: [
            "",
            "## Account Executive Diamond Shine",
            "- Positioning: \(gameplan.accountExecutiveEnablement.positioning)",
            "- Talk track: \(gameplan.accountExecutiveEnablement.talkTrack)",
            "",
            "### Discovery Questions"
        ])
        lines.append(contentsOf: gameplan.accountExecutiveEnablement.discoveryQuestions.map { "- \($0)" })

        lines.append(contentsOf: [
            "",
            "### Objection Handles"
        ])
        lines.append(contentsOf: gameplan.accountExecutiveEnablement.objectionHandles.map { "- \($0)" })

        lines.append(contentsOf: [
            "",
            "### Closing Plays"
        ])
        lines.append(contentsOf: gameplan.accountExecutiveEnablement.closingPlays.map { "- \($0)" })

        lines.append(contentsOf: [
            "",
            "## Offers"
        ])
        for offer in gameplan.offers {
            lines.append("- \(offer.name): \(offer.special.launchSentence) AE hook: \(offer.accountExecutiveHook.launchSentence) Proof: \(offer.proofRequired.launchSentence)")
        }

        lines.append(contentsOf: [
            "",
            "## Channels"
        ])
        for channel in gameplan.channels {
            lines.append("- \(channel.name): \(channel.motion.launchSentence) First touch: \(channel.firstTouch.launchSentence) Follow-up: \(channel.followUp.launchSentence) Compliance: \(channel.complianceNote.launchSentence)")
        }

        lines.append(contentsOf: [
            "",
            "## Action Queue"
        ])
        for action in actionQueue {
            lines.append("- Day \(action.dueDay) [\(action.phase.title)] \(action.ownerTitle): \(action.task) Proof: \(action.proof)")
        }

        lines.append(contentsOf: [
            "",
            "## Metrics"
        ])
        for metric in gameplan.metrics {
            lines.append("- \(metric.name): Target: \(metric.target.launchSentence) Source: \(metric.sourceOfTruth.launchSentence) Cadence: \(metric.inspectionCadence.launchSentence)")
        }

        lines.append(contentsOf: [
            "",
            "## Daily Standup Prompts"
        ])
        lines.append(contentsOf: dailyStandupPrompts.map { "- \($0)" })

        lines.append(contentsOf: [
            "",
            "## Guardrails"
        ])
        lines.append(contentsOf: gameplan.guardrails.map { "- \($0)" })

        return lines.joined(separator: "\n")
    }
}

public enum AgentOrchestrator {
    public static func run(
        _ gameplan: Gameplan,
        starting kickoffDate: Date = Date()
    ) -> OrchestratedLaunchPacket {
        let workstreams = buildWorkstreams(for: gameplan)
        let ownerBriefings = gameplan.roleLanes.map {
            OwnerBriefing(ownerTitle: $0.ownerTitle, mission: $0.mission, dailyActions: $0.dailyActions, handoff: $0.handoff)
        }
        let actions = buildActions(for: gameplan)
        let prompts = [
            "What changed in qualified pipeline since yesterday?",
            "Which account executive needs a blocker cleared today?",
            "Which buyer proof requirement is missing?",
            "Which message, offer, or demo moment needs tightening?",
            "What must be recorded before the next executive readout?"
        ]
        return OrchestratedLaunchPacket(
            gameplan: gameplan,
            kickoffDate: kickoffDate,
            workstreams: workstreams,
            ownerBriefings: ownerBriefings,
            dailyStandupPrompts: prompts,
            actionQueue: actions,
            readinessWarnings: launchReadinessWarnings(for: gameplan)
        )
    }

    public static func runBackToSchoolSpecials(starting kickoffDate: Date = Date()) -> OrchestratedLaunchPacket {
        run(.backToSchoolDiamondShine, starting: kickoffDate)
    }

    public static func launchReadinessWarnings(for gameplan: Gameplan) -> [String] {
        var warnings: [String] = []
        if gameplan.offers.isEmpty {
            warnings.append("No offers are defined.")
        }
        if gameplan.channels.isEmpty {
            warnings.append("No outreach channels are defined.")
        }
        if !gameplan.containsSignal("Account Executive") {
            warnings.append("The gameplan does not explicitly target account executives.")
        }
        if !gameplan.containsSignal("Diamond Shine") {
            warnings.append("The Diamond Shine standard is missing from the plan.")
        }
        if gameplan.metrics.isEmpty {
            warnings.append("No metrics are defined.")
        }
        if gameplan.guardrails.isEmpty {
            warnings.append("No launch guardrails are defined.")
        }
        return warnings
    }

    public static func diamondShineScore(for packet: OrchestratedLaunchPacket) -> Int {
        var score = 40
        if packet.readinessWarnings.isEmpty { score += 20 }
        if packet.actionQueue.contains(where: { $0.ownerTitle.localizedCaseInsensitiveContains("Account Executive") }) { score += 10 }
        if packet.actionQueue.allSatisfy({ !$0.proof.isEmpty }) { score += 10 }
        if packet.gameplan.metrics.count >= 5 { score += 10 }
        if packet.gameplan.guardrails.count >= 5 { score += 10 }
        return min(score, 100)
    }

    private static func buildWorkstreams(for gameplan: Gameplan) -> [LaunchWorkstream] {
        [
            LaunchWorkstream(
                name: "Offer Room",
                ownerTitle: "Launch Director",
                goal: "Keep every back-to-school special clear, approved, and ready for fast AE use.",
                operatingRule: "No offer goes live without proof requirement, urgency, and pricing boundary."
            ),
            LaunchWorkstream(
                name: "AE Diamond Shine Floor",
                ownerTitle: "Sales Enablement",
                goal: "Make account executives precise, polished, and consistent across discovery, demo, recap, and close plan.",
                operatingRule: "Every AE uses the talk track, asks discovery questions, and logs proof before next step."
            ),
            LaunchWorkstream(
                name: "Pipeline Sprint",
                ownerTitle: "Account Executive",
                goal: "Turn seasonal urgency into qualified meetings and dated next steps.",
                operatingRule: "Same-day recap or the opportunity does not count as Diamond Shine."
            ),
            LaunchWorkstream(
                name: "Customer Proof Loop",
                ownerTitle: "Customer Success",
                goal: "Find champions, expansion cues, referrals, and proof points without unsupported claims.",
                operatingRule: "Use only permissioned stories and recorded customer context."
            ),
            LaunchWorkstream(
                name: "Executive Readout",
                ownerTitle: "Launch Director",
                goal: "Show what worked, what missed, what closed, and what campaign runs next.",
                operatingRule: "Report pipeline, proof, quality, compliance, and next actions together."
            )
        ]
    }

    private static func buildActions(for gameplan: Gameplan) -> [LaunchAction] {
        var actions: [LaunchAction] = []

        for item in gameplan.kickoffChecklist {
            actions.append(
                LaunchAction(
                    dueDay: 0,
                    phase: .prepare,
                    ownerTitle: "Launch Director",
                    task: item,
                    proof: "Kickoff board item marked ready."
                )
            )
        }

        actions.append(
            LaunchAction(
                dueDay: 0,
                phase: .prepare,
                ownerTitle: "Sales Enablement",
                task: "Run Account Executive Diamond Shine role play using the seasonal talk track.",
                proof: "AE certification notes and top objection handle captured."
            )
        )

        for offer in gameplan.offers {
            actions.append(
                LaunchAction(
                    dueDay: 1,
                    phase: .activate,
                    ownerTitle: "Account Executive",
                    task: "Map priority accounts to \(offer.name) and identify the buyer pain.",
                    proof: offer.proofRequired
                )
            )
        }

        for channel in gameplan.channels {
            actions.append(
                LaunchAction(
                    dueDay: 2,
                    phase: .activate,
                    ownerTitle: "Account Executive",
                    task: "Launch \(channel.name) using first touch: \(channel.firstTouch)",
                    proof: channel.complianceNote
                )
            )
        }

        for lane in gameplan.roleLanes {
            for dailyAction in lane.dailyActions {
                actions.append(
                    LaunchAction(
                        dueDay: 3,
                        phase: .prove,
                        ownerTitle: lane.ownerTitle,
                        task: dailyAction,
                        proof: lane.handoff
                    )
                )
            }
        }

        for milestone in gameplan.milestones {
            let phase = phaseForMilestoneDay(milestone.day)
            actions.append(
                LaunchAction(
                    dueDay: milestone.day,
                    phase: phase,
                    ownerTitle: milestone.owner,
                    task: "Milestone: \(milestone.name). \(milestone.outcome)",
                    proof: "Milestone evidence logged in launch readout."
                )
            )
        }

        return actions
    }

    private static func phaseForMilestoneDay(_ day: Int) -> LaunchActionPhase {
        switch day {
        case 0...2: return .prepare
        case 3...10: return .activate
        case 11...20: return .prove
        case 21...29: return .close
        default: return .readout
        }
    }
}
