import SwiftUI

struct CafeListView: View {
    @EnvironmentObject var vm: CafeViewModel
    @State private var selectedCafe: Cafe? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.fMuted)
                    TextField("Café oder Stadt suchen...", text: $vm.searchText)
                        .font(.fBody)
                        .foregroundColor(.fPrimary)
                    if !vm.searchText.isEmpty {
                        Button {
                            vm.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.fMuted)
                        }
                    }
                }
                .padding(12)
                .background(Color.fCard)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 12)

                // Category filter
                CategoryScrollRow(selected: $vm.selectedCategory)
                    .padding(.bottom, 8)

                // Results count
                HStack {
                    Text("\(vm.filteredCafes.count) Cafés")
                        .font(.fCaption)
                        .foregroundColor(.fMuted)
                    Spacer()
                    // Sort indicator
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 11))
                        Text(vm.selectedFilter.rawValue)
                            .font(.fCaption)
                    }
                    .foregroundColor(.fAccent)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)

                // List
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(vm.filteredCafes) { cafe in
                            CafeListRow(cafe: cafe) {
                                vm.toggleFavorite(cafe)
                            }
                            .onTapGesture { selectedCafe = cafe }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.fBackground.ignoresSafeArea())
            .navigationTitle("Cafés")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedCafe) { cafe in
                CafeDetailView(cafe: cafe)
                    .environmentObject(vm)
            }
        }
    }
}

struct CafeListRow: View {
    let cafe: Cafe
    var onFavorite: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            CafeThumbnailView(cafe: cafe, size: 68)

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(cafe.name)
                        .font(.fHeadline)
                        .foregroundColor(.fPrimary)
                    Spacer()
                    Text(cafe.distanceFormatted)
                        .font(.fCaptionMed)
                        .foregroundColor(.fAccent)
                }

                HStack(spacing: 4) {
                    StarRatingView(rating: cafe.rating, size: 11)
                    Text(cafe.ratingFormatted)
                        .font(.fCaptionMed)
                        .foregroundColor(.fPrimary)
                    Text("· \(cafe.reviewCount)")
                        .font(.fCaption)
                        .foregroundColor(.fMuted)
                }

                HStack(spacing: 6) {
                    ViralBadgeView(source: cafe.viralSource, compact: true)
                    ForEach(cafe.categories.prefix(2)) { cat in
                        Text(cat.rawValue)
                            .font(.fMicro)
                            .foregroundColor(.fSecondary)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Color.fAccentLight)
                            .clipShape(Capsule())
                    }
                }
            }

            Button(action: onFavorite) {
                Image(systemName: cafe.isFavorite ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 17))
                    .foregroundColor(cafe.isFavorite ? .fAccent : .fMuted)
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .background(Color.fCard)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Color.fPrimary.opacity(0.07), radius: 8, x: 0, y: 2)
    }
}
