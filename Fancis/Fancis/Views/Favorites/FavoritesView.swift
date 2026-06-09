import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: CafeViewModel
    @State private var selectedCafe: Cafe? = nil

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            Group {
                if vm.favoriteCafes.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.favoriteCafes) { cafe in
                                FavoriteGridCard(cafe: cafe)
                                    .onTapGesture { selectedCafe = cafe }
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .background(Color.fBackground.ignoresSafeArea())
            .navigationTitle("Favoriten")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedCafe) { cafe in
                CafeDetailView(cafe: cafe)
                    .environmentObject(vm)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 52))
                .foregroundColor(.fMuted)
            Text("Noch keine Favoriten")
                .font(.fTitle2)
                .foregroundColor(.fPrimary)
            Text("Tippe das Lesezeichen-Symbol auf einem Café, um es hier zu speichern.")
                .font(.fBody)
                .foregroundColor(.fMuted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct FavoriteGridCard: View {
    let cafe: Cafe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    colors: [Color(hex: cafe.heroColor), Color(hex: cafe.heroColor).opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 120)

                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 38))
                    .foregroundColor(.white.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                ViralBadgeView(source: cafe.viralSource, compact: true)
                    .padding(8)
            }
            .frame(height: 120)
            .clipped()

            VStack(alignment: .leading, spacing: 5) {
                Text(cafe.name)
                    .font(.fBodyMed)
                    .foregroundColor(.fPrimary)
                    .lineLimit(1)
                Text(cafe.city)
                    .font(.fCaption)
                    .foregroundColor(.fMuted)
                HStack(spacing: 4) {
                    StarRatingView(rating: cafe.rating, size: 10)
                    Text(cafe.ratingFormatted)
                        .font(.fCaption)
                        .foregroundColor(.fSecondary)
                }
            }
            .padding(10)
        }
        .background(Color.fCard)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.fPrimary.opacity(0.07), radius: 8, x: 0, y: 3)
    }
}
