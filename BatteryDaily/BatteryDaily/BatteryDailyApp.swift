import SwiftUI

@main
struct BatteryDailyApp: App {
    var body: some Scene {
        WindowGroup {
            BatterySettingsView(snapshot: .sample)
                .preferredColorScheme(.dark)
                .tint(Theme.accent)
        }
    }
}
