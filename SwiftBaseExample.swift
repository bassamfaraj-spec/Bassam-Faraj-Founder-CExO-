import Foundation

/// Open, reusable example class for teams working with this module.
/// Provides a simple demonstration and a place to extend shared utilities.
open class SwiftBaseExample {
    public init() {}

    /// Prints a standard message identifying the module and author.
    open func printMessage() {
        print("Hello from SwiftBase by Bassam S Faraj Jr!")
    }
}

/// Open utilities to generate branded documents for teams.
/// These functions write Markdown files using the existing data models and letterheads.
public enum TeamDocumentGenerator {
    /// Writes the founder profile brief.
    @discardableResult
    public static func writeProfile(to directory: URL, bodyOnly: Bool = false) throws -> URL {
        let content = BassamFarajJr.profile.markdownBrief(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("Profile_Brief.md")
        try content.data(using: .utf8)?.write(to: url)
        return url
    }

    /// Writes the venture launch brief.
    @discardableResult
    public static func writeVentureLaunch(to directory: URL, bodyOnly: Bool = false) throws -> URL {
        let content = BassamFarajJr.ventureLaunch.markdownBrief(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("Venture_Launch_Brief.md")
        try content.data(using: .utf8)?.write(to: url)
        return url
    }

    /// Writes the aerospace portfolio brief.
    @discardableResult
    public static func writeAerospacePortfolio(to directory: URL, bodyOnly: Bool = false) throws -> URL {
        let content = BassamFarajJr.aerospacePortfolio.markdownBrief(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("Aerospace_Portfolio_Brief.md")
        try content.data(using: .utf8)?.write(to: url)
        return url
    }

    /// Writes the confidential breakdown.
    @discardableResult
    public static func writeConfidentialBreakdown(to directory: URL, bodyOnly: Bool = false) throws -> URL {
        let content = BassamFarajJr.confidentialBreakdown(bodyOnly: bodyOnly)
        let url = directory.appendingPathComponent("Founder_Portfolio_Confidential.md")
        try content.data(using: .utf8)?.write(to: url)
        return url
    }

    /// Generates all standard documents and returns their file URLs.
    @discardableResult
    public static func generateAll(to directory: URL, bodyOnly: Bool = false) throws -> [URL] {
        var urls: [URL] = []
        urls.append(try writeProfile(to: directory, bodyOnly: bodyOnly))
        urls.append(try writeVentureLaunch(to: directory, bodyOnly: bodyOnly))
        urls.append(try writeAerospacePortfolio(to: directory, bodyOnly: bodyOnly))
        urls.append(try writeConfidentialBreakdown(to: directory, bodyOnly: bodyOnly))
        return urls
    }
}
