import SwiftUI

struct BrightnessWarningCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(LinearGradient(
                        colors: [
                            Color(red: 0.35, green: 0.72, blue: 1.0),
                            Color(red: 0.04, green: 0.45, blue: 0.95)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(width: 38, height: 38)
                    .overlay {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                    }

                Text("高亮度")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Theme.textPrimary)

                Spacer(minLength: 8)

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Theme.textTertiary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)

            Hairline(leadingInset: 66)

            Text("显示屏亮度高会消耗大量的电量。请考虑降低亮度以改善电池续航能力。")
                .font(.system(size: 15))
                .foregroundStyle(Theme.textSecondary)
                .lineSpacing(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
        }
        .background(Theme.card, in: RoundedRectangle(cornerRadius: Theme.cardRadius, style: .continuous))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        BrightnessWarningCard().padding(16)
    }
}
