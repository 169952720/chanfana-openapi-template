import SwiftUI

struct BatterySettingsView: View {
    let snapshot: BatteryUsageSnapshot

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar

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
    }

    private var navigationBar: some View {
        ZStack {
            Text("电池")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Theme.textPrimary)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Theme.textPrimary)
                        .frame(width: 34, height: 34)
                        .background(Theme.backButtonFill, in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("返回")

                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
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
