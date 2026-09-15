import Foundation

public struct LaunchMobilizationFootprintSection: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var bullets: [String]

    public init(title: String, bullets: [String]) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.bullets = bullets
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

public struct LaunchMobilizationFootprint: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var summary: String
    public var sections: [LaunchMobilizationFootprintSection]

    public init(title: String, summary: String, sections: [LaunchMobilizationFootprintSection]) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.summary = summary.trimmingCharacters(in: .whitespacesAndNewlines)
        self.sections = sections
    }

    public func markdown(bodyOnly: Bool = false) -> String {
        var lines: [String] = [
            "# \(title)",
            "",
            summary
        ]

        for section in sections {
            lines.append("")
            lines.append("## \(section.title)")
            lines.append(contentsOf: section.bullets.map { "- \($0)" })
        }

        let body = lines.joined(separator: "\n")
        guard !bodyOnly else { return body }

        return [
            "---",
            "title: \(yamlQuoted(title))",
            "audience: \(yamlQuoted("Products, services, creators, and industry partners"))",
            "classification: \(yamlQuoted("Launch, testing, and mobilization operating footprint"))",
            "---",
            "",
            body
        ].joined(separator: "\n")
    }

    private func yamlQuoted(_ value: String) -> String {
        let escaped = value
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        return "\"\(escaped)\""
    }

    public static let standard = LaunchMobilizationFootprint(
        title: "Launch Mobilization Footprint",
        summary: "A footprint for debugging, pre-release review, kickoff, launch, testing, creator activation, IP rollout, and top-tier recruiting across products, services, and arts-and-leisure channels.",
        sections: [
            LaunchMobilizationFootprintSection(
                title: "Debug and Hardening Footprint",
                bullets: [
                    "List every product, service, workflow, and content asset with owner, current build state, blocker, rollback path, and proof needed before external visibility.",
                    "Run debug validation on core journeys, payment paths, account recovery, content publishing flows, and service escalations before pre-release access expands.",
                    "Capture known issues, severity, workarounds, and fix owners in one dated release log so launch claims stay aligned with reality."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Pre-Release and Kickoff Footprint",
                bullets: [
                    "Gate pre-release on approved scope, tested surfaces, support coverage, legal review, and clear go or no-go ownership.",
                    "Open kickoff with launch calendar, war room, reporting cadence, creator brief, press-ready talking points, and escalation routes for every major lane.",
                    "Separate public teaser material from private roadmaps, contracts, unreleased assets, and sensitive business operations."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Testing on All Products and Services",
                bullets: [
                    "Test apps, websites, media exports, subscriptions, onboarding, customer support, partner handoff, and reporting workflows on the devices and channels that matter most.",
                    "Use pilot groups for personal, business, sports, entertainment, fashion, arts, and leisure audiences so each segment yields feedback before broad release.",
                    "Require pass or fail evidence, user feedback, open issues, and retest dates for every release candidate."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Social Mobilization and Creator Deck",
                bullets: [
                    "Prepare content creators with approved brand language, publishing calendar, launch links, audience targets, and escalation rules for questions or claims.",
                    "Align short-form video, music, livestream, interviews, product demos, community posts, and behind-the-scenes content to the same release milestones.",
                    "Track which channels, creators, and campaigns convert attention into trials, purchases, bookings, signups, or qualified partner conversations."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Intellectual Property Rollout",
                bullets: [
                    "Route music, video, film, creative campaigns, and other intellectual property through rights checks, metadata readiness, distribution timing, and approved marketing packages.",
                    "Keep masters, contracts, unreleased edits, and partner-only assets in controlled systems with named owners and access logs.",
                    "Launch each IP asset with a supporting story, audience, call to action, and follow-up metric instead of posting without a business objective."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Recruiting the Best Across Industries",
                bullets: [
                    "Build a recruiting lane for operators, athletes, entertainers, designers, creators, technologists, and service leaders with clear role briefs and value exchange.",
                    "Prioritize proven talent who can raise execution quality, credibility, audience reach, or partner access without weakening privacy, safety, or brand discipline.",
                    "Record outreach status, warm introductions, meetings, and next asks so recruiting becomes part of the operating system rather than an ad hoc effort."
                ]
            ),
            LaunchMobilizationFootprintSection(
                title: "Launch Readout",
                bullets: [
                    "At release, compare build readiness, testing coverage, creator activation, revenue motion, audience response, and recruiting progress in one executive readout.",
                    "Keep the next release, hotfix, social push, and partnership follow-up already assigned before the first launch wave cools down.",
                    "Use evidence from the readout to decide whether to scale, patch, pause, or reposition each product, service, or content property."
                ]
            )
        ]
    )
}
