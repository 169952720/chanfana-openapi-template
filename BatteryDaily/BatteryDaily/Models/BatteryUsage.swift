import Foundation

/// 图表里的一根柱子。
struct DailyUsagePoint: Identifiable {
    let id = UUID()
    let weekday: String
    let percent: Double
    let isToday: Bool
}

/// 「App 和系统活动」里的一行。
struct BatteryAppActivity: Identifiable {
    enum IconKind {
        case douyin
        case hotspot
        case wechat
        case camera
        case music
        case system
    }

    let id = UUID()
    let name: String
    let icon: IconKind
    let foregroundMinutes: Int?
    let backgroundMinutes: Int?
    let percent: Int

    var detailLines: [String] {
        var lines: [String] = []
        if let foregroundMinutes {
            lines.append("屏幕活跃：\(foregroundMinutes.usageText)")
        }
        if let backgroundMinutes {
            lines.append("后台：\(backgroundMinutes.usageText)")
        }
        return lines
    }
}

extension Int {
    /// 198 -> "3 小时 18 分钟"
    var usageText: String {
        guard self >= 60 else { return "\(self) 分钟" }
        let hours = self / 60
        let minutes = self % 60
        return minutes == 0 ? "\(hours) 小时" : "\(hours) 小时 \(minutes) 分钟"
    }
}

/// 整页的数据快照。
///
/// 说明：iOS 没有向第三方 App 开放「每个 App 的耗电百分比」，
/// 系统电池页读取的是私有数据。这里先用样例数据把界面做完整，
/// 真实数据可以来自自建的统计模型（例如 MetricKit + 自己记录的耗电曲线）。
struct BatteryUsageSnapshot {
    let cutoff: String
    let averagePercent: Double
    let todayPercent: Double
    let points: [DailyUsagePoint]
    let activities: [BatteryAppActivity]

    static let sample = BatteryUsageSnapshot(
        cutoff: "22:44",
        averagePercent: 203,
        todayPercent: 165,
        points: [
            DailyUsagePoint(weekday: "三", percent: 186, isToday: false),
            DailyUsagePoint(weekday: "四", percent: 199, isToday: false),
            DailyUsagePoint(weekday: "五", percent: 208, isToday: false),
            DailyUsagePoint(weekday: "六", percent: 232, isToday: false),
            DailyUsagePoint(weekday: "日", percent: 190, isToday: false),
            DailyUsagePoint(weekday: "一", percent: 199, isToday: false),
            DailyUsagePoint(weekday: "二", percent: 207, isToday: false),
            DailyUsagePoint(weekday: "三", percent: 165, isToday: true)
        ],
        activities: [
            BatteryAppActivity(name: "抖音", icon: .douyin, foregroundMinutes: 198, backgroundMinutes: 7, percent: 82),
            BatteryAppActivity(name: "个人热点", icon: .hotspot, foregroundMinutes: nil, backgroundMinutes: nil, percent: 14),
            BatteryAppActivity(name: "微信", icon: .wechat, foregroundMinutes: 34, backgroundMinutes: 21, percent: 13),
            BatteryAppActivity(name: "相机", icon: .camera, foregroundMinutes: 12, backgroundMinutes: nil, percent: 4),
            BatteryAppActivity(name: "音乐", icon: .music, foregroundMinutes: 8, backgroundMinutes: nil, percent: 3),
            BatteryAppActivity(name: "系统服务", icon: .system, foregroundMinutes: nil, backgroundMinutes: 112, percent: 9)
        ]
    )
}
