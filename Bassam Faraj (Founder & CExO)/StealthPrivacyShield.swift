import Foundation

public struct StealthPrivacyShieldSection: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var bullets: [String]

    public init(title: String, bullets: [String]) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.bullets = bullets
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

public struct StealthPrivacyShield: Equatable, Hashable, Codable, Sendable {
    public var title: String
    public var summary: String
    public var sections: [StealthPrivacyShieldSection]

    public init(title: String, summary: String, sections: [StealthPrivacyShieldSection]) {
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
            "audience: \(yamlQuoted("Personal and Business Technology"))",
            "classification: \(yamlQuoted("Operational privacy and security checklist"))",
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

    public static let standard = StealthPrivacyShield(
        title: "Stealth Privacy Shield",
        summary: "A practical privacy and security shield for phones, computers, apps, cloud accounts, networks, and business systems used in personal and professional life.",
        sections: [
            StealthPrivacyShieldSection(
                title: "Universal Guardrails",
                bullets: [
                    "Keep passwords, recovery codes, API keys, customer data, and legal records out of source control, shared drives, and public messaging threads.",
                    "Use unique passwords, phishing-resistant MFA when available, and a trusted password manager for every critical account.",
                    "Reduce unnecessary data collection, app permissions, browser extensions, and connected integrations to only what is needed."
                ]
            ),
            StealthPrivacyShieldSection(
                title: "Personal Technology Shield",
                bullets: [
                    "Protect Apple, Google, Microsoft, carrier, banking, social, and email accounts from a trusted device and review recovery contacts often.",
                    "Keep phones, tablets, laptops, routers, and smart-home devices updated, encrypted, screen-locked, and free of unknown profiles or remote-management tools.",
                    "Review camera, microphone, location, Bluetooth, photo-library, and accessibility permissions so private data is shared intentionally."
                ]
            ),
            StealthPrivacyShieldSection(
                title: "Business Technology Shield",
                bullets: [
                    "Separate business systems from personal accounts with role-based access, approved devices, documented owners, and offboarding checklists.",
                    "Protect customer, employee, vendor, and financial data with least-privilege access, encrypted storage, secure backups, and retention limits.",
                    "Require verified approval before changing payment details, domains, DNS, identity providers, payroll, or production infrastructure."
                ]
            ),
            StealthPrivacyShieldSection(
                title: "Network, Application, and Device Safety",
                bullets: [
                    "Use secure Wi-Fi, VPN only when trusted, and segmented networks for guests, workstations, servers, and IoT devices.",
                    "Audit login history, active sessions, OAuth grants, app passwords, forwarding rules, and automation tokens on a recurring schedule.",
                    "Confirm backups can be restored, security tools are current, and critical alerts route to a monitored person or mailbox."
                ]
            ),
            StealthPrivacyShieldSection(
                title: "Incident Readiness",
                bullets: [
                    "When compromise is suspected, preserve evidence first, rotate credentials from a trusted device, and revoke unknown sessions before making broad changes.",
                    "Maintain a recovery runbook for carrier lock, SIM-swap protection, email recovery, identity-provider escalation, and legal or compliance reporting needs.",
                    "Document the incident timeline, affected systems, decisions made, and follow-up hardening tasks so the same weakness does not return."
                ]
            )
        ]
    )
}
