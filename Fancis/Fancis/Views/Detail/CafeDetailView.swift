import SwiftUI
import MapKit

struct CafeDetailView: View {
    let cafe: Cafe
    @EnvironmentObject var vm: CafeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showWriteReview = false
    @State private var scrollOffset: CGFloat = 0

    // Live version from VM
    private var liveCafe: Cafe {
        vm.cafes.first(where: { $0.id == cafe.id }) ?? cafe
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                infoSection
                categoriesSection
                whyViralSection
                viralDishesSection
                reviewsSection
                mapPreviewSection
                Spacer(minLength: 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.fBackground)
        .overlay(alignment: .top) { floatingNavBar }
        .sheet(isPresented: $showWriteReview) {
            WriteReviewView(cafe: liveCafe) { review in
                vm.writeReview(for: cafe, review: review)
            }
        }
    }

    // MARK: - Hero
    private var heroSection: some View {
        ZStack(alignment: .topLeading) {
            CafeHeroView(cafe: liveCafe, height: 280)

            // Bottom gradient for text legibility
            VStack {
                Spacer()
                LinearGradient(
                    colors: [Color.clear, Color.fPrimary.opacity(0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 120)
            }
            .frame(height: 280)

            // Hero text
            VStack(alignment: .leading, spacing: 6) {
                Spacer()
                ViralBadgeView(source: liveCafe.viralSource)
                Text(liveCafe.name)
                    .font(.fDisplay)
                    .foregroundColor(.white)
                HStack(spacing: 8) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.white.opacity(0.8))
                    Text("\(liveCafe.city) · \(liveCafe.distanceFormatted) entfernt")
                        .font(.fBodyMed)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(height: 280)
    }

    // MARK: - Info row
    private var infoSection: some View {
        VStack(spacing: 16) {
            // Rating + actions
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        StarRatingView(rating: liveCafe.rating, size: 14)
                        Text(liveCafe.ratingFormatted)
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                        Text("(\(liveCafe.reviewCount) Bewertungen)")
                            .font(.fCaption)
                            .foregroundColor(.fMuted)
                    }
                    HStack(spacing: 12) {
                        Label(liveCafe.openingHours, systemImage: "clock")
                            .font(.fCaption)
                            .foregroundColor(.fSecondary)
                    }
                    HStack(spacing: 6) {
                        Text(liveCafe.priceLevel.rawValue)
                            .font(.fCaptionMed)
                            .foregroundColor(.fAccent)
                        Text("·")
                            .foregroundColor(.fMuted)
                        Text(liveCafe.address)
                            .font(.fCaption)
                            .foregroundColor(.fMuted)
                            .lineLimit(1)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            // Action buttons
            HStack(spacing: 12) {
                // Directions
                ActionButton(
                    icon: "arrow.triangle.turn.up.right.circle.fill",
                    label: "Route",
                    color: .fAccent,
                    filled: true
                ) {
                    openMaps(for: liveCafe)
                }

                // Favorite
                ActionButton(
                    icon: liveCafe.isFavorite ? "bookmark.fill" : "bookmark",
                    label: liveCafe.isFavorite ? "Gespeichert" : "Speichern",
                    color: liveCafe.isFavorite ? .fAccent : .fSecondary,
                    filled: liveCafe.isFavorite
                ) {
                    vm.toggleFavorite(liveCafe)
                }

                // Share
                ActionButton(icon: "square.and.arrow.up", label: "Teilen", color: .fSecondary, filled: false) {
                    shareSheet()
                }
            }
            .padding(.horizontal, 20)

            Divider()
                .background(Color.fDivider)
                .padding(.horizontal, 20)
        }
    }

    // MARK: - Categories
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kategorien")
                .font(.fHeadline)
                .foregroundColor(.fPrimary)
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(liveCafe.categories) { cat in
                        CategoryChipView(category: cat)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 16)
    }

    // MARK: - Why Viral
    private var whyViralSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.fViralRed)
                Text("Warum ist es viral?")
                    .font(.fHeadline)
                    .foregroundColor(.fPrimary)
            }

            Text(liveCafe.whyViral)
                .font(.fBody)
                .foregroundColor(.fSecondary)
                .lineSpacing(4)
                .padding(16)
                .background(
                    LinearGradient(
                        colors: [Color.fViralRed.opacity(0.06), Color.fViralRed.opacity(0.03)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.fViralRed.opacity(0.15), lineWidth: 1)
                )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }

    // MARK: - Viral Dishes
    @ViewBuilder
    private var viralDishesSection: some View {
        if !liveCafe.dishes.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "fork.knife.circle.fill")
                            .foregroundColor(.fAccent)
                        Text("Virale Gerichte")
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                    }
                    Spacer()
                    Text("\(liveCafe.dishes.count) Empfehlungen")
                        .font(.fCaption)
                        .foregroundColor(.fMuted)
                }
                .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(liveCafe.dishes) { dish in
                            DishCardView(dish: dish)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 24)
        }
    }

    // MARK: - Reviews
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "star.bubble.fill")
                        .foregroundColor(.fAccent)
                    Text("Rezensionen")
                        .font(.fHeadline)
                        .foregroundColor(.fPrimary)
                }
                Spacer()
                Button {
                    showWriteReview = true
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .semibold))
                        Text("Schreiben")
                            .font(.fCaptionMed)
                    }
                    .foregroundColor(.fAccent)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.fAccentLight)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)

            if liveCafe.reviews.isEmpty {
                Text("Noch keine Rezensionen. Schreibe die erste!")
                    .font(.fBody)
                    .foregroundColor(.fMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
            } else {
                VStack(spacing: 12) {
                    ForEach(liveCafe.reviews) { review in
                        ReviewCardView(review: review)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .padding(.bottom, 24)
    }

    // MARK: - Map Preview
    private var mapPreviewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Lage")
                .font(.fHeadline)
                .foregroundColor(.fPrimary)
                .padding(.horizontal, 20)

            ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: liveCafe.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                )), annotationItems: [liveCafe]) { c in
                    MapAnnotation(coordinate: c.coordinate) {
                        CafeMapPinView(cafe: c, isSelected: true)
                    }
                }
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .allowsHitTesting(false)

                Button {
                    openMaps(for: liveCafe)
                } label: {
                    Label("In Maps öffnen", systemImage: "arrow.triangle.turn.up.right.circle.fill")
                        .font(.fCaptionMed)
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.fAccent)
                        .clipShape(Capsule())
                }
                .padding(12)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 24)
    }

    // MARK: - Floating Nav
    private var floatingNavBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.fPrimary)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            Spacer()
            Button {
                vm.toggleFavorite(liveCafe)
            } label: {
                Image(systemName: liveCafe.isFavorite ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(liveCafe.isFavorite ? .fAccent : .fPrimary)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 52)
    }

    // MARK: - Actions
    private func openMaps(for cafe: Cafe) {
        let q = cafe.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "maps://?q=\(q)") {
            UIApplication.shared.open(url)
        }
    }

    private func shareSheet() {
        let text = "Schau dir \(liveCafe.name) in \(liveCafe.city) an! \(liveCafe.viralSource.rawValue) 🔥"
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController?
            .present(av, animated: true)
    }
}

// MARK: - Action Button Component
struct ActionButton: View {
    let icon: String
    let label: String
    let color: Color
    let filled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(filled ? .white : color)
                    .frame(width: 52, height: 52)
                    .background(filled ? color : color.opacity(0.12))
                    .clipShape(Circle())
                Text(label)
                    .font(.fMicro)
                    .foregroundColor(.fSecondary)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}
