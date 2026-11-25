import SwiftUI

struct BatterySettingsView: View {
    let snapshot: BatteryUsageSnapshot

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    ScreenHeader(title: "电池") {
                        dismiss()
                    }

                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            BrightnessWarningCard()
                                .padding(.horizontal, 16)
                                .padding(.top, 8)

                            sectionHeader("每日用量")
                                .padding(.top, 26)

                            UsageCard(snapshot: snapshot)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)

                            Color.clear.frame(height: 32)
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Theme.textSecondary)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview("电池 · 每日用量") {
    BatterySettingsView(snapshot: .sample)
        .preferredColorScheme(.dark)
}
