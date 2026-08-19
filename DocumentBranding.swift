public enum DocumentBranding {
    public enum BrandStyle {
        public let name: String
        public let accentHex: String
        public let contacts: [String]

        public init(name: String, accentHex: String, contacts: [String]) {
            self.name = name
            self.accentHex = accentHex
            self.contacts = contacts
        }
    }

    public static let defaultBrand = BrandStyle(
        name: "Default",
        accentHex: "#FF0000",
        contacts: ["default@example.com"]
    )

    public static func prependLetterhead(_ body: String, letterhead: Letterhead) -> String {
        var lines: [String] = [
            "---",
            "brand: \(letterhead.style.name)",
            "kind: \(letterhead.kind.rawValue)",
            "accent: \(letterhead.style.accentHex)",
            "subtitle: \(letterhead.subtitle)",
            "contacts:"
        ]
        lines.append(contentsOf: letterhead.style.contacts.map { "- \($0)" })
        if let disclaimer = letterhead.disclaimer, !disclaimer.isEmpty {
            lines.append("disclaimer: \(disclaimer)")
        }
        lines.append("---")
        lines.append("")
        lines.append(body)
        return lines.joined(separator: "\n")
    }
}

public typealias BrandStyle = DocumentBranding.BrandStyle

public enum EntityKind: String, Codable, Sendable {
    case individual
    case company
    case program
    case confidential
}

public struct Letterhead: Equatable, Hashable, Codable, Sendable {
    public var style: BrandStyle
    public var kind: EntityKind
    public var subtitle: String
    public var disclaimer: String?

    public init(style: BrandStyle, kind: EntityKind, subtitle: String, disclaimer: String?) {
        self.style = style
        self.kind = kind
        self.subtitle = subtitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.disclaimer = disclaimer?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public enum BrandPalette {
    /// Phoenix Hovan default brand style with contacts.
    public static let phoenixHovan = BrandStyle(
        name: "Phoenix Hovan",
        accentHex: "#0B5FFF",
        contacts: [
            "bassam@phoenixhovan.com",
            "business@phoenixhovan.com",
            "+1-614-615-3444"
        ]
    )

    public static let founderPersonal = BrandStyle(
        name: "Bassam S Faraj Jr",
        accentHex: "#B91C1C",
        contacts: phoenixHovan.contacts
    )
}

private extension String {
    func isValidHexColor() -> Bool {
        let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
