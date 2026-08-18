import Foundation

public enum DocumentBranding {
    public struct BrandStyle {
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
}

public enum BrandPalette {
    /// Phoenix Hovan default brand style with contacts.
    public static let phoenixHovan = DocumentBranding.BrandStyle(
        name: "Phoenix Hovan",
        accentHex: "#0B5FFF",
        contacts: [
            "bassam@phoenixhovan.com",
            "business@phoenixhovan.com",
            "+1-614-615-3444"
        ]
    )
}

private extension String {
    func isValidHexColor() -> Bool {
        let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
