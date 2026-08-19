import SwiftUI
import Foundation
import StoreKit
import Combine

public struct TeamExportView: View {
    @State private var exportDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    @State private var bodyOnly: Bool = false
    @State private var billToName: String = "Client Name"
    @State private var hours: String = "8.0"
    @State private var hourlyRate: String = "250"
    @State private var statusMessage: String = ""
    @State private var grantedProducts: [String] = []
    @State private var hasBootRefreshed: Bool = false
    @State private var showingAssistant = false

    public init() {}

    public var body: some View {
        VStack {
            Form {
                Section("Documents") {
                    Toggle("Body only (no letterhead)", isOn: $bodyOnly)
                    Button("Generate All Docs") { generateAllDocs() }
                    Button("Run Initiative Launch Shield") {
                        runInitiative(focus: "Security, launch readiness, and account recovery")
                    }
                    Button("Create Keelport AR Cascade") {
                        generateKeelportCascade()
                    }
                    Button("Restore & Verify Purchases") { Task { await restoreAndVerify() } }
                    Button("Manage Subscriptions") { manageSubscriptions() }
                    Button("Ask Phoenix Assistant") { showingAssistant = true }
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

                if !grantedProducts.isEmpty {
                    Section("Entitlements") {
                        ForEach(grantedProducts, id: \.self) { product in
                            Text(product)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingAssistant) {
            NavigationStack {
                AssistantView()
            }
        }
        .task {
            if !hasBootRefreshed {
                hasBootRefreshed = true
                await loadCachedEntitlements()
                await refreshGrantedFromBackend()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .assistantGenerateDocs)) { note in
            if let body = note.userInfo?[AssistantActionKeys.bodyOnly] as? Bool {
                bodyOnly = body
            }
            generateAllDocs()
        }
        .onReceive(NotificationCenter.default.publisher(for: .assistantCreateInvoice)) { note in
            if let name = note.userInfo?[AssistantActionKeys.billToName] as? String {
                billToName = name
            }
            if let h = note.userInfo?[AssistantActionKeys.hours] as? Double {
                hours = String(h)
            }
            if let r = note.userInfo?[AssistantActionKeys.hourlyRate] as? Double {
                hourlyRate = String(r)
            }
            createInvoice()
        }
        .onReceive(NotificationCenter.default.publisher(for: .assistantRestoreVerify)) { _ in
            Task { await restoreAndVerify() }
        }
        .onReceive(NotificationCenter.default.publisher(for: .assistantRunInitiative)) { note in
            let focus = note.userInfo?[AssistantActionKeys.focus] as? String
            let includeContactRouting = note.userInfo?[AssistantActionKeys.includeContactRouting] as? Bool ?? false
            runInitiative(
                focus: focus ?? "Security, launch readiness, and account recovery",
                includeContactRouting: includeContactRouting
            )
        }
        .onReceive(NotificationCenter.default.publisher(for: .assistantGenerateKeelportCascade)) { note in
            let focus = note.userInfo?[AssistantActionKeys.focus] as? String
            let includeAppStoreConnectChecklist = note.userInfo?[AssistantActionKeys.includeAppStoreConnectChecklist] as? Bool ?? true
            let includeAdultAndSubstanceSafety = note.userInfo?[AssistantActionKeys.includeAdultAndSubstanceSafety] as? Bool ?? true
            generateKeelportCascade(
                focus: focus ?? "AR assistants, product cascade, media quality, and AI safety",
                includeAppStoreConnectChecklist: includeAppStoreConnectChecklist,
                includeAdultAndSubstanceSafety: includeAdultAndSubstanceSafety
            )
        }
    }

    private func generateAllDocs() {
        do {
            let urls = try TeamDocumentGenerator.generateAll(to: exportDirectory, bodyOnly: bodyOnly)
            statusMessage = "Generated: \n" + urls.map { $0.lastPathComponent }.joined(separator: "\n")
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
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
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        }
    }

    private func runInitiative(focus: String, includeContactRouting: Bool = false) {
        do {
            let url = try TeamDocumentGenerator.writeInitiativeLaunchShield(
                to: exportDirectory,
                focus: focus,
                includeContactRouting: includeContactRouting,
                bodyOnly: bodyOnly
            )
            statusMessage = "Initiative launch shield created: \(url.lastPathComponent)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        }
    }

    private func generateKeelportCascade(
        focus: String = "AR assistants, product cascade, media quality, and AI safety",
        includeAppStoreConnectChecklist: Bool = true,
        includeAdultAndSubstanceSafety: Bool = true
    ) {
        do {
            let url = try TeamDocumentGenerator.writeKeelportCascade(
                to: exportDirectory,
                focus: focus,
                includeAppStoreConnectChecklist: includeAppStoreConnectChecklist,
                includeAdultAndSubstanceSafety: includeAdultAndSubstanceSafety,
                bodyOnly: bodyOnly
            )
            statusMessage = "Keelport cascade created: \(url.lastPathComponent)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        } catch {
            statusMessage = "Error: \(error.localizedDescription)"
            NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
        }
    }

    private func restoreAndVerify() async {
        await MainActor.run {
            statusMessage = "Restoring..."
        }
        do {
            let result = try await StorefrontVerifier.shared.restoreAndVerify()
            await MainActor.run {
                statusMessage = result
                NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
            }
            await refreshGrantedFromBackend()
        } catch {
            await MainActor.run {
                statusMessage = "Error: \(error.localizedDescription)"
                NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
            }
        }
    }

    private func refreshGrantedFromBackend() async {
        let grantedURL = StorefrontVerifier.backendVerifyURL.appendingPathComponent("granted")
        do {
            let (data, _) = try await URLSession.shared.data(from: grantedURL)
            let granted = try JSONDecoder().decode([String].self, from: data)
            await cacheEntitlements(granted)
            await MainActor.run {
                grantedProducts = granted
                NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: "Entitlements refreshed: \(granted.count)"])
            }
        } catch {
            await MainActor.run {
                statusMessage += "\nFailed to refresh entitlements: \(error.localizedDescription)"
                NotificationCenter.default.post(name: .assistantActionStatus, object: nil, userInfo: [AssistantStatusKeys.message: statusMessage])
            }
        }
    }

    private func manageSubscriptions() {
        Task {
            await MainActor.run {
                statusMessage = "Opening subscriptions..."
            }
            await StorefrontVerifier.shared.manageSubscriptions()
        }
    }

    private func loadCachedEntitlements() async {
        await MainActor.run {
            if let cached = UserDefaults.standard.array(forKey: "grantedProducts") as? [String] {
                grantedProducts = cached
            }
        }
    }

    private func cacheEntitlements(_ list: [String]) async {
        UserDefaults.standard.set(list, forKey: "grantedProducts")
    }
}

#Preview {
    TeamExportView()
}
