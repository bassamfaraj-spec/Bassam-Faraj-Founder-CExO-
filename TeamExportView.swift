import SwiftUI
import Foundation

public struct TeamExportView: View {
    @State private var exportDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    @State private var bodyOnly: Bool = false
    @State private var billToName: String = "Client Name"
    @State private var hours: String = "8.0"
    @State private var hourlyRate: String = "250"
    @State private var statusMessage: String = ""

    public init() {}

    public var body: some View {
        Form {
            Section("Documents") {
                Toggle("Body only (no letterhead)", isOn: $bodyOnly)
                Button("Generate All Docs") { generateAllDocs() }
            }

            Section("Invoice — Get Paid Today") {
                TextField("Bill To Name", text: $billToName)
                TextField("Hours", text: $hours)
                    .keyboardType(.decimalPad)
                TextField("Hourly Rate", text: $hourlyRate)
                    .keyboardType(.decimalPad)
                Button("Create Hourly Invoice") { createInvoice() }
            }

            if !statusMessage.isEmpty {
                Section("Status") {
                    Text(statusMessage)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private func generateAllDocs() {
        do {
            let urls = try TeamDocumentGenerator.generateAll(to: exportDirectory, bodyOnly: bodyOnly)
            statusMessage = "Generated: \n" + urls.map { $0.lastPathComponent }.joined(separator: "\n")
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }

    private func createInvoice() {
        do {
            let h = Decimal(string: hours) ?? 0
            let r = Decimal(string: hourlyRate) ?? 0
            let url = try InvoiceGenerator.writeHourlyInvoice(
                to: exportDirectory,
                billToName: billToName,
                hours: h,
                hourlyRate: r,
                letterheadStyle: BrandPalette.founderPersonal
            )
            statusMessage = "Invoice created: \(url.lastPathComponent)"
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    TeamExportView()
}
