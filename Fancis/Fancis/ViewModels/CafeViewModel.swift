import Foundation
import Combine
import CoreLocation

enum FilterTab: String, CaseIterable {
    case viral     = "Viral"
    case nearby    = "In deiner Nähe"
    case newest    = "Neu"
}

class CafeViewModel: ObservableObject {
    @Published var cafes: [Cafe] = MockData.cafes
    @Published var selectedFilter: FilterTab = .viral
    @Published var selectedCategory: CafeCategory? = nil
    @Published var selectedCafe: Cafe? = nil
    @Published var searchText: String = ""
    @Published var showFilters: Bool = false

    var filteredCafes: [Cafe] {
        var result = cafes

        // Search
        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.categories.contains(where: { $0.rawValue.localizedCaseInsensitiveContains(searchText) })
            }
        }

        // Category filter
        if let cat = selectedCategory {
            result = result.filter { $0.categories.contains(cat) }
        }

        // Tab filter
        switch selectedFilter {
        case .viral:
            result = result.sorted { $0.reviewCount > $1.reviewCount }
        case .nearby:
            result = result.sorted { $0.distance < $1.distance }
        case .newest:
            result = result.sorted { $0.rating > $1.rating }
        }

        return result
    }

    var favoriteCafes: [Cafe] {
        cafes.filter { $0.isFavorite }
    }

    func toggleFavorite(_ cafe: Cafe) {
        guard let idx = cafes.firstIndex(where: { $0.id == cafe.id }) else { return }
        cafes[idx].isFavorite.toggle()
        // Update selectedCafe if open
        if selectedCafe?.id == cafe.id {
            selectedCafe = cafes[idx]
        }
    }

    func writeReview(for cafe: Cafe, review: Review) {
        guard let idx = cafes.firstIndex(where: { $0.id == cafe.id }) else { return }
        cafes[idx].reviews.insert(review, at: 0)
    }
}
