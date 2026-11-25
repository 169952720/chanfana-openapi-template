import SwiftUI

struct AppActivityRow: View {
    let activity: BatteryAppActivity

    var body: some View {
        HStack(spacing: 12) {
            AppIconBadge(kind: activity.icon)

            VStack(alignment: .leading, spacing: 2) {
                Text(activity.name)
                    .font(.system(size: 17))
                    .foregroundStyle(Theme.textPrimary)

                ForEach(activity.detailLines, id: \.self) { line in
                    Text(line)
                        .font(.system(size: 13))
                        .foregroundStyle(Theme.textSecondary)
                }
            }

            Spacer(minLength: 8)

            Text("\(activity.percent)%")
                .font(.system(size: 17))
                .monospacedDigit()
                .foregroundStyle(Theme.textPrimary)

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Theme.textTertiary)
        }
        .padding(.leading, 16)
        .padding(.trailing, 14)
        .padding(.vertical, 11)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 0) {
            ForEach(BatteryUsageSnapshot.sample.activities) { activity in
                AppActivityRow(activity: activity)
                Hairline(leadingInset: 66)
            }
        }
        .background(Theme.card)
    }
}
