import SwiftUI

/// App 图标角标。示例里的抖音 / 热点 / 微信都用矢量绘制，
/// 避免工程里塞入有版权的图标资源。
struct AppIconBadge: View {
    let kind: BatteryAppActivity.IconKind

    var body: some View {
        RoundedRectangle(cornerRadius: 9, style: .continuous)
            .fill(fill)
            .frame(width: 38, height: 38)
            .overlay { symbol }
            .overlay {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.08), lineWidth: 0.5)
            }
    }

    private var fill: AnyShapeStyle {
        switch kind {
        case .douyin:
            return AnyShapeStyle(Color.black)
        case .hotspot:
            return AnyShapeStyle(LinearGradient(
                colors: [
                    Color(red: 0.32, green: 0.86, blue: 0.47),
                    Color(red: 0.13, green: 0.68, blue: 0.30)
                ],
                startPoint: .top,
                endPoint: .bottom
            ))
        case .wechat:
            return AnyShapeStyle(LinearGradient(
                colors: [
                    Color(red: 0.17, green: 0.81, blue: 0.43),
                    Color(red: 0.04, green: 0.65, blue: 0.30)
                ],
                startPoint: .top,
                endPoint: .bottom
            ))
        }
    }

    @ViewBuilder
    private var symbol: some View {
        switch kind {
        case .douyin:
            // 用三层错位的音符模拟抖音的双色抖动 Logo
            ZStack {
                Image(systemName: "music.note")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color(red: 0.15, green: 0.90, blue: 0.95))
                    .offset(x: -1.5, y: -1.5)

                Image(systemName: "music.note")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color(red: 1.0, green: 0.25, blue: 0.45))
                    .offset(x: 1.5, y: 1.5)

                Image(systemName: "music.note")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
        case .hotspot:
            Image(systemName: "personalhotspot")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
        case .wechat:
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HStack(spacing: 16) {
            AppIconBadge(kind: .douyin)
            AppIconBadge(kind: .hotspot)
            AppIconBadge(kind: .wechat)
        }
    }
}
