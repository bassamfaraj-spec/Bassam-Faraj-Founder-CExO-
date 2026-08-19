import Foundation

public struct FounderBriefSection: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var bullets: [String]

    public init(title: String, bullets: [String]) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.bullets = bullets
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

public struct FounderBrief: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var summary: String
    public var sections: [FounderBriefSection]
    public var letterheadSubtitle: String
    public var entityKind: EntityKind

    public init(
        title: String,
        summary: String,
        sections: [FounderBriefSection],
        letterheadSubtitle: String,
        entityKind: EntityKind = .individual
    ) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.summary = summary.trimmingCharacters(in: .whitespacesAndNewlines)
        self.sections = sections
        self.letterheadSubtitle = letterheadSubtitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.entityKind = entityKind
    }

    public func markdownBrief(bodyOnly: Bool = false) -> String {
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
        if bodyOnly {
            return body
        }

        let letterhead = Letterhead(
            style: BrandStyle(name: title, accentHex: BrandPalette.phoenixHovan.accentHex, contacts: BrandPalette.phoenixHovan.contacts),
            kind: entityKind,
            subtitle: letterheadSubtitle,
            disclaimer: nil
        )
        return DocumentBranding.prependLetterhead(body, letterhead: letterhead)
    }
}

public enum BassamFarajJr {
    public static let profile = FounderBrief(
        title: "Bassam S Faraj Jr",
        summary: "CEO, CExO, and founder building a practical operating layer for business, software, hardware, services, and launch execution.",
        sections: [
            FounderBriefSection(
                title: "Operating Principles",
                bullets: [
                    "Convert broad vision into scoped products, documents, invoices, workflows, and measurable next actions.",
                    "Keep sensitive account, phone, email, and recovery details out of source control and public launch material.",
                    "Separate public promotion from private technical, security, financial, and partner details."
                ]
            ),
            FounderBriefSection(
                title: "Initiatives",
                bullets: [
                    "Founder Operating System: reusable structure for decisions, documents, product work, and follow-through.",
                    "Product and Brand Studio: launch copy, advertising assets, partner briefs, and customer-facing materials.",
                    "Security Launch Shield: account recovery, carrier protection, email sync checks, and provider escalation."
                ]
            )
        ],
        letterheadSubtitle: "CEO | CExO | Founder"
    )

    public static let ventureLaunch = FounderBrief(
        title: "Phoenix Hovan Venture Launch",
        summary: "A launch plan for turning products, apps, software, services, and partner concepts into protected, testable, revenue-ready work.",
        sections: [
            FounderBriefSection(
                title: "Launch Tools",
                bullets: [
                    "Generate founder briefs, confidential breakdowns, launch sheets, and invoices from the app.",
                    "Build each product with a public offer, private operating notes, owner, status, next action, and proof needed.",
                    "Use clear advertising claims that can be supported by current product evidence and legal review."
                ]
            ),
            FounderBriefSection(
                title: "Partner Readiness",
                bullets: [
                    "Require written scope, consent, confidentiality, payment route, and decision owner before sharing private materials.",
                    "Track leads by audience: customers, partners, suppliers, investors, carriers, service providers, and counsel.",
                    "Keep regulated, medical, aerospace, emergency, and financial claims behind expert review."
                ]
            )
        ],
        letterheadSubtitle: "Venture Launch",
        entityKind: .program
    )

    public static let aerospacePortfolio = FounderBrief(
        title: "Protected Hardware and Aerospace Portfolio",
        summary: "A research-first portfolio for hardware, aerospace, mobility, and service ideas that stays simulation-first and review-gated.",
        sections: [
            FounderBriefSection(
                title: "Safety Gate",
                bullets: [
                    "No flight, medical, emergency, defense, or life-safety claim is launch-ready without qualified review.",
                    "Keep technical assumptions in an evidence log before hardware spend or public marketing.",
                    "Separate customer experience concepts from regulated engineering systems."
                ]
            ),
            FounderBriefSection(
                title: "Commercial Path",
                bullets: [
                    "Start with briefs, simulations, prototypes, service workflows, and partner-safe demos.",
                    "Use licensing, paid discovery, sponsorship, and service packages before capital-heavy buildout.",
                    "Protect drawings, code, supplier lists, and partner decks with access controls and agreements."
                ]
            )
        ],
        letterheadSubtitle: "Hardware and Aerospace Portfolio",
        entityKind: .program
    )

    public static func confidentialBreakdown(bodyOnly: Bool = false) -> String {
        let body = [
            "# Confidential Founder Portfolio Breakdown",
            "",
            profile.markdownBrief(bodyOnly: true),
            "",
            ventureLaunch.markdownBrief(bodyOnly: true),
            "",
            aerospacePortfolio.markdownBrief(bodyOnly: true),
            "",
            "## Confidentiality",
            "- Do not distribute private account, carrier, phone, email, partner, product, or technical details without written consent.",
            "- Keep security recovery steps, provider case numbers, API keys, and account evidence out of public launch material."
        ].joined(separator: "\n")

        if bodyOnly {
            return body
        }

        let letterhead = Letterhead(
            style: BrandPalette.founderPersonal,
            kind: .confidential,
            subtitle: "Founder Portfolio Breakdown",
            disclaimer: "Confidential. Do not distribute without express written consent."
        )
        return DocumentBranding.prependLetterhead(body, letterhead: letterhead)
    }

    public static func initiativeLaunchShield(
        focus: String,
        includeContactRouting: Bool = false,
        bodyOnly: Bool = false
    ) -> String {
        let cleanedFocus = focus.trimmingCharacters(in: .whitespacesAndNewlines)
        let primaryFocus = cleanedFocus.isEmpty ? "Security, launch readiness, and account recovery" : cleanedFocus
        var lines: [String] = [
            "# Initiative Launch Shield",
            "",
            "Primary focus: \(primaryFocus)",
            "",
            "## Boundaries",
            "- This app can generate documents and checklists. It cannot directly modify carrier, VoIP, email, OpenAI, Apple, or device account settings without dedicated provider access.",
            "- Treat suspected hacks or spyware as an evidence and recovery workflow: preserve proof, rotate credentials, review sessions, and escalate with providers.",
            "- Keep phone numbers, email aliases, recovery contacts, API keys, and provider case numbers in a secure password manager or provider portal, not source code.",
            "",
            "## Security Shield",
            "- Rotate Apple ID, email, carrier, OpenAI, banking, domain, and password-manager credentials from a trusted device.",
            "- Enable MFA, remove unknown devices, remove unknown OAuth grants, revoke stale API keys, and review recovery emails and phone numbers.",
            "- Ask carriers and VoIP providers for a port freeze, SIM swap lock, account PIN, call-forwarding review, device list review, and fraud case number.",
            "- Review email aliases, forwarding, filters, app passwords, mailbox rules, DKIM, SPF, DMARC, and connected mail clients.",
            "- Update iOS, macOS, and apps; inspect VPN, profiles, MDM, accessibility permissions, login items, and unknown management tools.",
            "",
            "## Launch Tools",
            "- Generate profile, venture, aerospace, confidential, initiative, and invoice documents from the app.",
            "- Split every product into public offer, private notes, owner, next action, proof needed, risk gate, and launch channel.",
            "- Build ad copy only from supported claims, current pricing, live inventory, and reviewed legal or regulated language.",
            "- Use signed scope, payment terms, confidentiality, and permissioned outreach before partner handoff.",
            "",
            "## 48 Hour Action List",
            "- Create provider recovery tickets for phone, VoIP, email, Apple ID, OpenAI, domain, and financial accounts.",
            "- Export current product list, partner list, ad assets needed, invoices due, and launch blockers.",
            "- Rotate sensitive keys and passwords, then document which devices and sessions remain trusted.",
            "- Produce one public launch sheet and one confidential operating sheet per priority product."
        ]

        if includeContactRouting {
            lines.append("")
            lines.append("## Contact Routing")
            lines.append("- Add the Batline, emergency VoIP, main phone, and email aliases inside the relevant carrier, VoIP, Apple, email, and password-manager accounts.")
            lines.append("- Verify call forwarding, voicemail, SMS routing, recovery phone numbers, and mail alias delivery with provider-side logs.")
            lines.append("- Do not publish private recovery routes in public ads, repositories, or customer-facing documents.")
        }

        let body = lines.joined(separator: "\n")
        if bodyOnly {
            return body
        }

        let letterhead = Letterhead(
            style: BrandPalette.founderPersonal,
            kind: .confidential,
            subtitle: "Initiative Launch Shield",
            disclaimer: "Operational checklist. Provider account changes require direct verification with each provider."
        )
        return DocumentBranding.prependLetterhead(body, letterhead: letterhead)
    }
}
