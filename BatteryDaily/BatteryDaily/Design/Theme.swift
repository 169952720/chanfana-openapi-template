import SwiftUI

/// 配色与尺寸常量，数值对着 iOS 18「电池 › 每日用量」深色界面取。
enum Theme {
    // 背景与容器
    static let background = Color.black
    static let card = Color(red: 0.11, green: 0.11, blue: 0.12)            // #1C1C1E
    static let separator = Color.white.opacity(0.08)
    static let backButtonFill = Color(white: 0.20)

    // 文字
    static let textPrimary = Color.white
    static let textSecondary = Color(red: 0.56, green: 0.56, blue: 0.58)    // #8E8E93
    static let textTertiary = Color(red: 0.40, green: 0.40, blue: 0.42)
    static let averageNumber = Color(red: 0.78, green: 0.78, blue: 0.80)

    // 主题色
    static let accent = Color(red: 0.04, green: 0.52, blue: 1.0)            // #0A84FF
    static let chartBaseline = Color(white: 0.38)

    // 柱状图渐变：顶部略亮、底部压暗，和系统图表的质感一致
    static let barGray = LinearGradient(
        colors: [Color(white: 0.56), Color(white: 0.31)],
        startPoint: .top,
        endPoint: .bottom
    )
    static let barToday = LinearGradient(
        colors: [Color(red: 0.27, green: 0.65, blue: 1.0), Color(red: 0.0, green: 0.37, blue: 0.93)],
        startPoint: .top,
        endPoint: .bottom
    )

    static let cardRadius: CGFloat = 24
}
