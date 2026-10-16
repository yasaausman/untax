import AppIntents
import MoneyKit
import UntaxKit
import SharedKit
import SwiftData
import SwiftUI
import UserNotifications

@main
struct UntaxApp: App {
    @State private var dependencies: AppDependencies
    private let container: ModelContainer

    init() {
        let container: ModelContainer
        do {
            container = try SharedStore.makeContainer()
        } catch {
            fatalError("Couldn't open the shared store: \(error)")
        }
        self.container = container
        _dependencies = State(initialValue: .live(container: container))
        RevenueCatBootstrap.configureIfPossible()
        UNUserNotificationCenter.current().delegate = ForegroundNotificationPresenter.shared
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(dependencies)
                .environment(\.moneyEscalation, dependencies.moneyEscalation)
                .environment(\.completionLedger, dependencies.ledger)
                .environment(\.proEntitlements, dependencies.pro)
                .environment(\.untax, dependencies.untax)
                .task { await dependencies.pro.start() }
        }
        .modelContainer(container)
    }
}

/// Pulls App Intents (the alarm's Stop/Decide intents) out of the local packages.
struct UntaxAppIntentsPackage: AppIntentsPackage {
    static var includedPackages: [any AppIntentsPackage.Type] {
        [MoneyKitIntentsPackage.self]
    }
}
