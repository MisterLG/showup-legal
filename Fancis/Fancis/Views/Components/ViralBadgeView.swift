import SwiftUI

struct ViralBadgeView: View {
    let source: ViralSource
    var compact: Bool = false

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: source.icon)
                .font(.system(size: compact ? 9 : 11, weight: .bold))
            if !compact {
                Text(source.rawValue)
                    .font(.fMicro)
                    .lineLimit(1)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, compact ? 8 : 10)
        .padding(.vertical, compact ? 4 : 5)
        .background(
            LinearGradient(
                colors: [Color(hex: "E8614B"), Color(hex: "C4474F")],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(Capsule())
    }
}
