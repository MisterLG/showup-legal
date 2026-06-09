import SwiftUI

struct ReviewCardView: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(Color(hex: review.avatarColor))
                        .frame(width: 36, height: 36)
                    Text(review.authorInitial)
                        .font(.fBodyMed)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(review.authorName)
                        .font(.fBodyMed)
                        .foregroundColor(.fPrimary)
                    HStack(spacing: 4) {
                        StarRatingView(rating: review.rating, size: 10)
                        Text(review.date.relativeFormatted)
                            .font(.fMicro)
                            .foregroundColor(.fMuted)
                    }
                }
                Spacer()
            }

            Text(review.text)
                .font(.fBody)
                .foregroundColor(.fSecondary)
                .lineSpacing(3)
        }
        .fancisCard()
    }
}

extension Date {
    var relativeFormatted: String {
        let days = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
        switch days {
        case 0: return "Heute"
        case 1: return "Gestern"
        case 2...6: return "Vor \(days) Tagen"
        case 7...13: return "Vor einer Woche"
        case 14...27: return "Vor \(days / 7) Wochen"
        default:
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.locale = Locale(identifier: "de_DE")
            return formatter.string(from: self)
        }
    }
}
