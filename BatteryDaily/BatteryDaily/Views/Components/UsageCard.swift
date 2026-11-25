import SwiftUI

/// 「每日用量」整张卡片：摘要、平均/今天、柱状图、图例，以及 App 和系统活动。
struct UsageCard: View {
    let snapshot: BatteryUsageSnapshot

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            summary
                .padding(.horizontal, 16)
                .padding(.top, 16)

            Hairline(leadingInset: 16)
                .padding(.top, 14)

            statistics
                .padding(.horizontal, 16)
                .padding(.top, 14)

            UsageBarChart(points: snapshot.points, averagePercent: snapshot.averagePercent)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            legend
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 16)

            Hairline()

            Text("App 和系统活动")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Theme.textPrimary.opacity(0.92))
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 6)

            ForEach(snapshot.activities) { activity in
                AppActivityRow(activity: activity)

                if activity.id != snapshot.activities.last?.id {
                    Hairline(leadingInset: 66)
                }
            }

            Hairline()

            Button {
                // 演示工程：真实 App 里在这里跳转到完整的用量列表
            } label: {
                HStack {
                    Text("查看所有电池用量")
                        .font(.system(size: 17))
                        .foregroundStyle(Theme.textPrimary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Theme.textTertiary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .background(Theme.card, in: RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
    }

    private var summary: Text {
        var leading = AttributedString("截至 \(snapshot.cutoff)，")
        leading.foregroundColor = Theme.textSecondary

        var trailing = AttributedString("今天使用电量与往常持平。")
        trailing.foregroundColor = Theme.textPrimary

        return Text(leading + trailing)
            .font(.system(size: 15, weight: .semibold))
    }

    private var statistics: some View {
        HStack(alignment: .top, spacing: 58) {
            statItem(
                label: "平均",
                value: snapshot.averagePercent,
                labelColor: Theme.textSecondary,
                valueColor: Theme.averageNumber
            )
            statItem(
                label: "今天",
                value: snapshot.todayPercent,
                labelColor: Theme.accent,
                valueColor: Theme.accent
            )
            Spacer(minLength: 0)
        }
    }

    private func statItem(label: String, value: Double, labelColor: Color, valueColor: Color) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(labelColor)

            Text("\(Int(value))%")
                .font(.system(size: 32, weight: .semibold))
                .monospacedDigit()
                .foregroundStyle(valueColor)
                .padding(.top, 2)
        }
    }

    private var legend: some View {
        HStack(spacing: 18) {
            legendItem("全天")
            legendItem("每日截至 \(snapshot.cutoff)")
        }
    }

    private func legendItem(_ title: String) -> some View {
        HStack(spacing: 5) {
            Circle()
                .fill(Color(white: 0.62))
                .frame(width: 6, height: 6)

            Text(title)
                .font(.system(size: 12))
                .foregroundStyle(Theme.textSecondary)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView {
            UsageCard(snapshot: .sample).padding(16)
        }
    }
}
