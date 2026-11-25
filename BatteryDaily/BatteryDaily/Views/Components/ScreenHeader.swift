import SwiftUI

/// 系统电池页同款的自定义导航头：居中标、左侧悬浮圆形返回钮。
struct ScreenHeader: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Theme.textPrimary)

            HStack {
                Button(action: onBack) {
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
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScreenHeader(title: "电池") {}
    }
}
