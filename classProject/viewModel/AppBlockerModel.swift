import Foundation
import SwiftUI
import ManagedSettings
import DeviceActivity
import FamilyControls

class AppBlockerModel: ObservableObject {
    static let shared = AppBlockerModel()

    public let store = ManagedSettingsStore()
    private let center = DeviceActivityCenter()

    @Published var selectionToDiscourage: FamilyActivitySelection = .init()

    @AppStorage("applicationTokensData",
                store: UserDefaults(suiteName: "group.com.yourcompany.appblocker"))
    private var applicationTokensData: Data?

    init() {
        loadSelectionFromStorage()
    }

    func lockApps() {
        // Make sure selectionToDiscourage actually has content
        print("Apps: \(selectionToDiscourage.applicationTokens.count), " +
              "Categories: \(selectionToDiscourage.categoryTokens.count), " +
              "Domains: \(selectionToDiscourage.webDomainTokens.count)")

        store.shield.applications = selectionToDiscourage.applicationTokens
        store.shield.applicationCategories = .specific(selectionToDiscourage.categoryTokens)
        store.shield.webDomains = selectionToDiscourage.webDomainTokens

        print("lockApps() called")
    }


    func unlockApps() {
        store.clearAllSettings()
        print("Apps unlocked")
    }

    private func loadSelectionFromStorage() {
        guard let data = applicationTokensData else { return }
        if let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
            selectionToDiscourage = decoded
        }
    }

    func saveSelectionToStorage() {
        if let data = try? JSONEncoder().encode(selectionToDiscourage) {
            applicationTokensData = data
        }
    }
}
