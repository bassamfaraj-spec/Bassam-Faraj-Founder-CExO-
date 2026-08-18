import Foundation

public struct InvoiceLineItem: Equatable, Hashable, Codable, Sendable {
    public var description: String
    public var quantity: Decimal
    public var unitPrice: Decimal

    public init(description: String, quantity: Decimal, unitPrice: Decimal) {
        self.description = description.trimmingCharacters(in: .whitespacesAndNewlines)
        self.quantity = quantity
        self.unitPrice = unitPrice
    }

    public var lineTotal: Decimal {
        decimalMultiply(quantity, unitPrice)
    }
}

public struct Invoice: Equatable, Hashable, Codable, Sendable {
    public var invoiceNumber: String
    public var issueDate: Date
    public var dueDate: Date
    public var billToName: String
    public var billToAddress: String?
    public var items: [InvoiceLineItem]
    public var currencyCode: String
    public var taxRatePercent: Decimal
    public var notes: String?

    public init(
        invoiceNumber: String,
        issueDate: Date,
        dueDate: Date,
        billToName: String,
        billToAddress: String? = nil,
        items: [InvoiceLineItem],
        currencyCode: String = "USD",
        taxRatePercent: Decimal = 0,
        notes: String? = nil
    ) {
        self.invoiceNumber = invoiceNumber
        self.issueDate = issueDate
        self.dueDate = dueDate
        self.billToName = billToName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.billToAddress = billToAddress?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.items = items
        self.currencyCode = currencyCode
        self.taxRatePercent = taxRatePercent
        self.notes = notes?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var subtotal: Decimal {
        items.reduce(0) { partial, item in decimalAdd(partial, item.lineTotal) }
    }

    public var taxAmount: Decimal {
        guard taxRatePercent > 0 else { return 0 }
        let rate = decimalDivide(taxRatePercent, 100)
        return decimalMultiply(subtotal, rate)
    }

    public var total: Decimal {
        decimalAdd(subtotal, taxAmount)
    }

    public func markdownBody() -> String {
        var lines: [String] = []
        lines.append("# Invoice \(invoiceNumber)")
        lines.append("")
        lines.append("- Issue Date: \(format(date: issueDate))")
        lines.append("- Due Date: \(format(date: dueDate))")
        lines.append("")
        lines.append("## Bill To")
        lines.append("- \(billToName)")
        if let address = billToAddress, !address.isEmpty {
            lines.append("- \(address)")
        }
        lines.append("")
        lines.append("## Line Items")
        for item in items {
            lines.append("- \(item.description): \(formatDecimal(item.quantity)) × \(formatCurrency(item.unitPrice, currencyCode: currencyCode)) = \(formatCurrency(item.lineTotal, currencyCode: currencyCode))")
        }
        lines.append("")
        lines.append("## Totals")
        lines.append("- Subtotal: \(formatCurrency(subtotal, currencyCode: currencyCode))")
        if taxRatePercent > 0 {
            lines.append("- Tax (\(formatPercent(taxRatePercent))): \(formatCurrency(taxAmount, currencyCode: currencyCode))")
        }
        lines.append("- Total: \(formatCurrency(total, currencyCode: currencyCode))")
        if let notes, !notes.isEmpty {
            lines.append("")
            lines.append("## Notes")
            lines.append(notes)
        }
        return lines.joined(separator: "\n")
    }
}

public enum InvoiceGenerator {
    /// Writes an invoice as Markdown with a YAML letterhead using the given brand style.
    @discardableResult
    public static func write(
        to directory: URL,
        invoiceNumber: String? = nil,
        billToName: String,
        billToAddress: String? = nil,
        items: [InvoiceLineItem],
        currencyCode: String = "USD",
        taxRatePercent: Decimal = 0,
        dueInDays: Int = 14,
        letterheadStyle: BrandStyle = BrandPalette.founderPersonal,
        entityKind: EntityKind = .individual,
        bodyOnly: Bool = false,
        notes: String? = nil
    ) throws -> URL {
        let today = Date()
        let dueDate = Calendar.current.date(byAdding: .day, value: max(0, dueInDays), to: today) ?? today
        let number = invoiceNumber ?? Self.defaultInvoiceNumber(on: today)
        let invoice = Invoice(
            invoiceNumber: number,
            issueDate: today,
            dueDate: dueDate,
            billToName: billToName,
            billToAddress: billToAddress,
            items: items,
            currencyCode: currencyCode,
            taxRatePercent: taxRatePercent,
            notes: notes
        )
        let body = invoice.markdownBody()
        let content: String
        if bodyOnly {
            content = body
        } else {
            let head = Letterhead(style: letterheadStyle, kind: entityKind, subtitle: "Invoice", disclaimer: nil)
            content = DocumentBranding.prependLetterhead(body, letterhead: head)
        }
        let url = directory.appendingPathComponent("Invoice_\(number).md")
        try content.data(using: .utf8)?.write(to: url)
        return url
    }

    private static func defaultInvoiceNumber(on date: Date) -> String {
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyyMMdd"
        let d = df.string(from: date)
        let rand = Int.random(in: 1000...9999)
        return "INV-\(d)-\(rand)"
    }
}

// MARK: - Helpers

private func format(date: Date) -> String {
    let df = DateFormatter()
    df.calendar = Calendar(identifier: .gregorian)
    df.locale = Locale(identifier: "en_US_POSIX")
    df.dateFormat = "yyyy-MM-dd"
    return df.string(from: date)
}

private func formatCurrency(_ value: Decimal, currencyCode: String) -> String {
    let nf = NumberFormatter()
    nf.numberStyle = .currency
    nf.currencyCode = currencyCode
    return nf.string(from: value as NSDecimalNumber) ?? "\(value) \(currencyCode)"
}

private func formatPercent(_ value: Decimal) -> String {
    // Show as 0%..100% without multiplying by 100 again
    let nf = NumberFormatter()
    nf.numberStyle = .percent
    nf.maximumFractionDigits = 2
    let decimal = NSDecimalNumber(decimal: value)
    // NumberFormatter percent expects 0..1; divide by 100 if value > 1
    let adjusted: NSDecimalNumber = decimal.compare(1) == .orderedDescending ? decimal.dividing(by: 100) : decimal
    return nf.string(from: adjusted) ?? "\(value)%"
}

private func formatDecimal(_ value: Decimal) -> String {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 2
    return nf.string(from: value as NSDecimalNumber) ?? "\(value)"
}

private func decimalAdd(_ a: Decimal, _ b: Decimal) -> Decimal {
    var res = Decimal()
    var aa = a
    var bb = b
    NSDecimalAdd(&res, &aa, &bb, .plain)
    return res
}

private func decimalMultiply(_ a: Decimal, _ b: Decimal) -> Decimal {
    var res = Decimal()
    var aa = a
    var bb = b
    NSDecimalMultiply(&res, &aa, &bb, .plain)
    return res
}

private func decimalDivide(_ a: Decimal, _ b: Decimal) -> Decimal {
    var res = Decimal()
    var aa = a
    var bb = b
    NSDecimalDivide(&res, &aa, &bb, .plain)
    return res
}
