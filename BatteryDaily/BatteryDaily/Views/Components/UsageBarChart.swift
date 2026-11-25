import SwiftUI

/// 每天一根胶囊柱，今天用蓝色；背后一条平均参考线。
///
/// 这里没有用 Swift Charts：这张图不需要坐标轴和刻度，
/// 只需要「等宽柱 + 平均线 + 周几标签」，用布局直接画更精确，
/// 也更容易做出和系统一致的胶囊圆角与渐变色。
struct UsageBarChart: View {
    let points: [DailyUsagePoint]
    let averagePercent: Double

    @State private var appeared = false

    private let plotHeight: CGFloat = 122
    private let labelHeight: CGFloat = 20
    private let gap: CGFloat = 8
    private let barWidth: CGFloat = 22

    private var totalHeight: CGFloat {
        plotHeight + gap + labelHeight
    }

    /// 顶部留一点余量，最高的柱子不会顶到卡片边缘，平均线也有地方放标签。
    private var scaleCeiling: Double {
        max(points.map(\.percent).max() ?? 1, averagePercent) * 1.12
    }

    private var averageLineY: CGFloat {
        plotHeight * CGFloat(1 - averagePercent / scaleCeiling)
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(points) { point in
                VStack(spacing: gap) {
                    Spacer(minLength: 0)

                    Capsule(style: .continuous)
                        .fill(point.isToday ? Theme.barToday : Theme.barGray)
                        .frame(width: barWidth, height: barHeight(for: point))

                    Text(point.weekday)
                        .font(.system(size: 12, weight: point.isToday ? .semibold : .regular))
                        .foregroundStyle(point.isToday ? Theme.accent : Theme.textSecondary)
                        .frame(height: labelHeight)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(height: totalHeight)
        .background(alignment: .topLeading) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Theme.chartBaseline)
                    .frame(height: 1)
                    .offset(y: averageLineY)

                HStack {
                    Spacer()
                    Text("平均")
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textSecondary)
                }
                .offset(y: max(averageLineY - 17, 0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.65)) {
                appeared = true
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("最近 8 天的每日用量")
        .accessibilityValue("平均 \(Int(averagePercent))%，今天 \(Int(points.last?.percent ?? 0))%")
    }

    private func barHeight(for point: DailyUsagePoint) -> CGFloat {
        let fullHeight = plotHeight * CGFloat(point.percent / scaleCeiling)
        return appeared ? max(fullHeight, 4) : 3
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        UsageBarChart(points: BatteryUsageSnapshot.sample.points, averagePercent: 203)
            .padding(16)
    }
}
