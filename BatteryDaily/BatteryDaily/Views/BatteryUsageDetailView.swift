import SwiftUI

/// 「查看所有电池用量」的二级页：列出今天所有 App 与系统活动的占比。
struct BatteryUsageDetailView: View {
    let snapshot: BatteryUsageSnapshot

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader(title: "电池用量") {
                    dismiss()
                }

                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        HStack {
                            Text("App 和系统活动")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Theme.textSecondary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)

                        listCard
                            .padding(.horizontal, 16)
                            .padding(.top, 8)

                        Text("百分比表示该 App 占今天总用电量的比例，同一天内各项相加可能超过 100%。")
                            .font(.system(size: 12))
                            .foregroundStyle(Theme.textTertiary)
                            .lineSpacing(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 12)

                        Color.clear.frame(height: 32)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var listCard: some View {
        VStack(spacing: 0) {
            ForEach(snapshot.activities) { activity in
                AppActivityRow(activity: activity, showsChevron: false)

                if activity.id != snapshot.activities.last?.id {
                    Hairline(leadingInset: 66)
                }
            }
        }
        .background(Theme.card, in: RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        BatteryUsageDetailView(snapshot: .sample)
    }
    .preferredColorScheme(.dark)
}
