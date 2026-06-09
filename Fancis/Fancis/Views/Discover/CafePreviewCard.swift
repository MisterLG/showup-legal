import SwiftUI

struct CafePreviewCard: View {
    let cafe: Cafe
    var onTap: () -> Void
    var onFavorite: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                CafeThumbnailView(cafe: cafe, size: 72)

                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(cafe.name)
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                            .lineLimit(1)
                        Spacer()
                        ViralBadgeView(source: cafe.viralSource, compact: true)
                    }

                    Text("\(cafe.city) • \(cafe.distanceFormatted)")
                        .font(.fCaption)
                        .foregroundColor(.fMuted)

                    HStack(spacing: 6) {
                        StarRatingView(rating: cafe.rating, size: 11)
                        Text(cafe.ratingFormatted)
                            .font(.fCaptionMed)
                            .foregroundColor(.fPrimary)
                        Text("(\(cafe.reviewCount))")
                            .font(.fCaption)
                            .foregroundColor(.fMuted)
                    }

                    // First 2 categories
                    HStack(spacing: 6) {
                        ForEach(cafe.categories.prefix(2)) { cat in
                            Text(cat.rawValue)
                                .font(.fMicro)
                                .foregroundColor(.fSecondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.fAccentLight)
                                .clipShape(Capsule())
                        }
                    }
                }

                // Bookmark button
                Button(action: onFavorite) {
                    Image(systemName: cafe.isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 18))
                        .foregroundColor(cafe.isFavorite ? .fAccent : .fMuted)
                }
                .buttonStyle(.plain)
                .padding(.leading, 4)
            }
            .padding(16)
        }
        .buttonStyle(.plain)
        .background(Color.fCard)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.fPrimary.opacity(0.1), radius: 16, x: 0, y: -4)
    }
}
