import Foundation

public struct ExecutionPacket: Equatable, Hashable, Codable, Sendable, Identifiable {
    public var id: String { gameplan.id }
    public let gameplan: Gameplan
    public let statusUpdates: [StatusUpdate]
    public let releaseNotes: [ReleaseNote]
    public let commandCenter: KickoffCommandCenter
    public let startDate: Date

    public init(
        gameplan: Gameplan,
        statusUpdates: [StatusUpdate] = [],
        releaseNotes: [ReleaseNote] = [],
        commandCenter: KickoffCommandCenter? = nil,
        startDate: Date = .now
    ) {
        self.gameplan = gameplan
        self.statusUpdates = statusUpdates
        self.releaseNotes = releaseNotes
        self.startDate = startDate
        self.commandCenter = commandCenter ?? ExecutionPacketBuilder.kickoffCommandCenter(for: gameplan, date: startDate)
    }

    public var summary: String { gameplan.launchSummary }

    public func markdown() -> String {
        var sections = [
            AgentOrchestrator.run(gameplan, starting: startDate).markdown()
        ]

        if !statusUpdates.isEmpty {
            var lines = ["## Status Updates"]
            for update in statusUpdates {
                lines.append("- [\(update.severity.rawValue.uppercased())] \(update.title): \(update.message)")
                if !update.links.isEmpty {
                    lines.append("  Links: \(update.links.joined(separator: ", "))")
                }
            }
            sections.append(lines.joined(separator: "\n"))
        }

        if !releaseNotes.isEmpty {
            var lines = ["## Release Notes"]
            for note in releaseNotes {
                lines.append("- \(note.version): \(note.summary)")
                lines.append(contentsOf: note.changes.map { "  - \($0)" })
                if !note.knownIssues.isEmpty {
                    lines.append("  Known issues: \(note.knownIssues.joined(separator: "; "))")
                }
            }
            sections.append(lines.joined(separator: "\n"))
        }

        sections.append(commandCenter.markdown())
        return sections.joined(separator: "\n\n")
    }
}

public enum ExecutionPacketBuilder {
    public static func packet(for gameplan: Gameplan, date: Date = .now) -> ExecutionPacket {
        if gameplan.id == Gameplan.augustWeekendLift.id {
            return weekendLiftPacket(date: date)
        }
        if gameplan.id == Gameplan.certifiedRolloutEngine.id {
            return certifiedRolloutPacket(date: date)
        }
        return buildPacket(
            for: gameplan,
            date: date,
            statusUpdates: crossLaneStatusUpdates(for: gameplan),
            releaseNotes: releaseNotes(for: gameplan, date: date)
        )
    }

    public static func allLaunchPackets(date: Date = .now) -> [ExecutionPacket] {
        Gameplan.allPresets.map { packet(for: $0, date: date) }
    }

    public static func weekendLiftPacket(date: Date = .now) -> ExecutionPacket {
        let plan = Gameplan.augustWeekendLift
        let status = [
            StatusUpdate(title: "Weekend Blitz Kickoff", message: "War room open. Offer sheet and talk tracks approved.", severity: .notice),
            StatusUpdate(title: "Demo Hour Live", message: "Join the 20-minute demo; recap templates ready.", severity: .info)
        ] + crossLaneStatusUpdates(for: plan)
        let notes = [
            ReleaseNote(version: "2026.8.1", summary: "Weekend Blitz assets published.", changes: [
                "Talk tracks updated for weekend velocity.",
                "Recap templates include proof checklist.",
                "Status page and escalation paths documented."
            ])
        ]
        return buildPacket(for: plan, date: date, statusUpdates: status, releaseNotes: notes)
    }

    public static func certifiedRolloutPacket(date: Date = .now) -> ExecutionPacket {
        let plan = Gameplan.certifiedRolloutEngine
        let status = [
            StatusUpdate(title: "Certification Gate Open", message: "Templates and rollback plans approved.", severity: .notice),
            StatusUpdate(title: "Pilot Cohort Live", message: "Monitoring enabled; rollback verified.", severity: .info)
        ] + crossLaneStatusUpdates(for: plan)
        let notes = [
            ReleaseNote(version: "2026.8.1", summary: "Certified rollout materials published.", changes: [
                "Integration templates v1.",
                "Release cadence documented.",
                "Remediation office hours scheduled."
            ])
        ]
        return buildPacket(for: plan, date: date, statusUpdates: status, releaseNotes: notes)
    }

    public static func kickoffCommandCenter(for gameplan: Gameplan, date: Date = .now) -> KickoffCommandCenter {
        let launchOwner = ownerTitle(in: gameplan, matching: ["Launch Director", "Program Manager"], fallback: "Launch Director")
        let productOwner = ownerTitle(in: gameplan, matching: ["Product", "Solutions Architect"], fallback: launchOwner)
        let talentOwner = ownerTitle(in: gameplan, matching: ["Talent", "Sales Enablement"], fallback: "Talent Lead")
        let serviceOwner = ownerTitle(in: gameplan, matching: ["Customer Success", "Support", "SRE", "Services"], fallback: "Services Lead")
        let accountOwner = ownerTitle(in: gameplan, matching: ["Account Executive"], fallback: "Account Executive")
        let offerSummary = joinedNames(gameplan.offers.map(\.name), fallback: "approved offer set")
        let metricSummary = joinedNames(gameplan.metrics.map(\.name), fallback: "launch metrics")

        return KickoffCommandCenter(
            programTitle: gameplan.title,
            kickoffDate: date,
            launchModes: LaunchRunMode.allCases,
            lanes: OperatingLane.allCases,
            chatGPTHandoff: [
                "Capture the final ChatGPT strategy, prompts, claims, unresolved questions, and owner decisions.",
                "Move approved ChatGPT work into the launch packet, execution queue, dashboard, and report bundle.",
                "Keep one source of truth for prompts, status updates, release notes, and executive readouts."
            ],
            mergeChecklist: [
                "Deduplicate conflicting instructions before launch.",
                "Attach owner, due day, lane, mode, and proof requirement to every next step.",
                "Merge scheduled cadence and on-demand triggers into the same command center.",
                "Refresh reports after every material status, metric, offer, service, or talent change.",
                "Keep private customer, employee, student, and account data out of public artifacts."
            ],
            nextSteps: [
                KickoffNextStep(
                    dueDay: 0,
                    mode: .scheduled,
                    lane: .product,
                    ownerTitle: productOwner,
                    task: "Confirm launch surface, packaged scope, and readiness gate for \(offerSummary).",
                    proof: "Product readiness note linked to the kickoff board."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .scheduled,
                    lane: .program,
                    ownerTitle: launchOwner,
                    task: "Open kickoff room, launch calendar, decision log, and daily standup for \(gameplan.season).",
                    proof: "Kickoff room, calendar hold, and decision log are live."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .scheduled,
                    lane: .talent,
                    ownerTitle: talentOwner,
                    task: "Send role briefings to every owner and confirm who is active, backup, and blocked.",
                    proof: "Role briefing acknowledgements captured."
                ),
                KickoffNextStep(
                    dueDay: 1,
                    mode: .scheduled,
                    lane: .services,
                    ownerTitle: serviceOwner,
                    task: "Open service intake, coverage path, and escalation route for customers and internal teams.",
                    proof: "Service queue and escalation route published."
                ),
                KickoffNextStep(
                    dueDay: 1,
                    mode: .scheduled,
                    lane: .reporting,
                    ownerTitle: launchOwner,
                    task: "Refresh executive, pipeline, delivery, talent, and service reports from \(metricSummary).",
                    proof: "Report bundle timestamp and source checks recorded."
                ),
                KickoffNextStep(
                    dueDay: 2,
                    mode: .scheduled,
                    lane: .operations,
                    ownerTitle: launchOwner,
                    task: "Verify calendar, reminders, status artifacts, export path, and mobile review handoff.",
                    proof: "Mac and iPhone handoff checks completed."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .product,
                    ownerTitle: productOwner,
                    task: "Create a fast launch packet for a requested product, offer, or update.",
                    proof: "On-demand packet includes scope, owner, proof, and launch boundary."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .program,
                    ownerTitle: launchOwner,
                    task: "Clone the latest command center, resolve blockers, and start the launch queue immediately.",
                    proof: "Command center status moves to active with blocker list."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .talent,
                    ownerTitle: talentOwner,
                    task: "Route role-specific work to active talent and record acknowledgement.",
                    proof: "Talent lane owner and next action confirmed."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .services,
                    ownerTitle: serviceOwner,
                    task: "Triage customer, support, partner, or operations service request and assign owner.",
                    proof: "Service request has owner, severity, and next checkpoint."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .reporting,
                    ownerTitle: launchOwner,
                    task: "Export the latest report bundle for Mac review, phone review, and ChatGPT readout.",
                    proof: "Report files refreshed and delivery targets logged."
                ),
                KickoffNextStep(
                    dueDay: 0,
                    mode: .onDemand,
                    lane: .operations,
                    ownerTitle: accountOwner,
                    task: "Confirm buyer, stakeholder, calendar, and communication next step before work leaves the queue.",
                    proof: "Next contact, owner, and proof requirement recorded."
                )
            ],
            reportTargets: reportTargets(for: gameplan, metricSummary: metricSummary),
            deviceHandoffs: [
                DeviceHandoff(
                    deviceName: "Mac",
                    action: "Export markdown reports into the selected local folder and review the command center before merge.",
                    confirmation: "Finder-visible report files have current timestamps."
                ),
                DeviceHandoff(
                    deviceName: "iPhone",
                    action: "Review the latest command-center report through the shared file or mobile app handoff and trigger on-demand launch when needed.",
                    confirmation: "Mobile view shows the same status, owner, and next-step queue."
                )
            ]
        )
    }

    private static func buildPacket(
        for gameplan: Gameplan,
        date: Date,
        statusUpdates: [StatusUpdate],
        releaseNotes: [ReleaseNote]
    ) -> ExecutionPacket {
        ExecutionPacket(
            gameplan: gameplan,
            statusUpdates: statusUpdates,
            releaseNotes: releaseNotes,
            commandCenter: kickoffCommandCenter(for: gameplan, date: date),
            startDate: date
        )
    }

    private static func crossLaneStatusUpdates(for gameplan: Gameplan) -> [StatusUpdate] {
        [
            StatusUpdate(
                title: "ChatGPT Work Merged",
                message: "Approved ChatGPT strategy, prompts, kickoff notes, and report updates are ready to merge into \(gameplan.title).",
                severity: .notice
            ),
            StatusUpdate(
                title: "Scheduled and On-Demand Launch Ready",
                message: "Product, program, talent, services, operations, and reporting lanes can run on cadence or by request.",
                severity: .info
            )
        ]
    }

    private static func releaseNotes(for gameplan: Gameplan, date: Date) -> [ReleaseNote] {
        [
            ReleaseNote(
                version: releaseVersion(for: date),
                summary: "\(gameplan.title) command center published.",
                changes: [
                    "Added scheduled kickoff controls.",
                    "Added on-demand launch queue.",
                    "Added product, program, talent, services, operations, and reporting lanes.",
                    "Added Mac and iPhone report handoff targets."
                ]
            )
        ]
    }

    private static func reportTargets(for gameplan: Gameplan, metricSummary: String) -> [ReportRefreshTarget] {
        [
            ReportRefreshTarget(
                reportName: "Executive Launch Readout",
                audience: "Founder, executive team, launch owners",
                cadence: "Daily during launch and on demand after material change",
                sourceOfTruth: "Milestones, decision log, readiness warnings, and \(metricSummary)",
                deliveryTargets: ["Mac export folder", "iPhone review handoff", "ChatGPT readout"],
                updateRule: "Show wins, misses, blockers, risks, next decisions, and proof requirements together."
            ),
            ReportRefreshTarget(
                reportName: "Product and Program Status",
                audience: "Product, program, operations, and implementation owners",
                cadence: "Scheduled kickoff, daily standup, and every on-demand launch",
                sourceOfTruth: "Offer scope, milestones, rollout gates, and owner handoffs",
                deliveryTargets: ["Mac export folder", "Launch dashboard"],
                updateRule: "Refresh whenever scope, readiness, schedule, or launch mode changes."
            ),
            ReportRefreshTarget(
                reportName: "Talent Action Report",
                audience: "Account executives, enablement, support, services, and assigned talent",
                cadence: "Daily and on demand when owners change",
                sourceOfTruth: "Role lanes, action queue, handoffs, acknowledgements, and blockers",
                deliveryTargets: ["Mac export folder", "iPhone review handoff"],
                updateRule: "Every owner must have one current next step and one proof requirement."
            ),
            ReportRefreshTarget(
                reportName: "Service and Customer Report",
                audience: "Customer success, support, partners, and service operators",
                cadence: "Daily, incident-driven, and on demand",
                sourceOfTruth: "Service queue, customer proof, escalation log, and support status",
                deliveryTargets: ["Mac export folder", "ChatGPT readout"],
                updateRule: "Update after each customer, partner, service, incident, or remediation change."
            ),
            ReportRefreshTarget(
                reportName: "Finance and Pipeline Report",
                audience: "Founder, finance, sales, and program owners",
                cadence: "Daily while active and on demand before decisions",
                sourceOfTruth: "CRM pipeline, offers, metrics, pricing boundaries, and close plans",
                deliveryTargets: ["Mac export folder", "iPhone review handoff", "Launch dashboard"],
                updateRule: "Tie every forecast or revenue update to source evidence and next action."
            )
        ]
    }

    private static func ownerTitle(in gameplan: Gameplan, matching needles: [String], fallback: String) -> String {
        for lane in gameplan.roleLanes {
            if needles.contains(where: { lane.ownerTitle.localizedCaseInsensitiveContains($0) }) {
                return lane.ownerTitle
            }
        }
        return fallback
    }

    private static func joinedNames(_ names: [String], fallback: String) -> String {
        let filtered = names.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        guard !filtered.isEmpty else { return fallback }
        return filtered.prefix(3).joined(separator: ", ")
    }

    private static func releaseVersion(for date: Date) -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0).\(components.month ?? 0).\(components.day ?? 0)"
    }
}
