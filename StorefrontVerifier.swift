import Foundation
import StoreKit

public final class StorefrontVerifier {
    public static let shared = StorefrontVerifier()
    // TODO: Replace with your backend verify URL
    public static let backendVerifyURL = URL(string: "https://bassamfaraj.com/verify/storekit")!

    public func restoreAndVerify() async throws -> String {
        let result = try await AppStore.sync()
        var entitlementsForVerification: [[String: String]] = []

        for entitlement in result.currentEntitlements {
            let verifiedTransaction = try checkVerified(entitlement.verified)
            var entry: [String: String] = ["productId": verifiedTransaction.productID]
            if let transactionID = verifiedTransaction.transaction.id {
                entry["transactionId"] = String(transactionID)
            }
            entitlementsForVerification.append(entry)
        }

        var request = URLRequest(url: Self.backendVerifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = ["entitlements": entitlementsForVerification]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "StorefrontVerifier",
                          code: 1,
                          userInfo: [NSLocalizedDescriptionKey : "Network error or invalid response"])
        }

        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dict = json as? [String: Any],
              let status = dict["status"] as? String else {
            throw NSError(domain: "StorefrontVerifier",
                          code: 2,
                          userInfo: [NSLocalizedDescriptionKey : "Malformed response"])
        }

        if status != "ok" {
            let message = dict["message"] as? String ?? "Unknown error"
            throw NSError(domain: "StorefrontVerifier",
                          code: 3,
                          userInfo: [NSLocalizedDescriptionKey : message])
        }

        let granted = dict["granted"] as? [String] ?? []

        return "Verified \(entitlementsForVerification.count) entitlements (\(granted.count) granted)"
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let safe):
            return safe
        case .unverified:
            throw NSError(domain: "StorefrontVerifier",
                          code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "Transaction unverified"])
        }
    }

    public func manageSubscriptions() async {
        if #available(iOS 15.0, macOS 12.0, *) {
            // Use StoreKit's built-in manage subscriptions API if available
            await AppStore.showManageSubscriptions()
        } else {
            // Fallback to opening the subscriptions URL in the App Store
            if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                #if os(iOS)
                await MainActor.run {
                    UIApplication.shared.open(url)
                }
                #elseif os(macOS)
                NSWorkspace.shared.open(url)
                #endif
            }
        }
    }
}
