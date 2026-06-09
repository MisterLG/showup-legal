import Foundation
import CoreLocation

struct Cafe: Identifiable {
    let id: UUID
    var name: String
    var city: String
    var address: String
    var distance: Double // km
    var rating: Double
    var reviewCount: Int
    var viralSource: ViralSource
    var categories: [CafeCategory]
    var whyViral: String
    var coordinate: CLLocationCoordinate2D
    var heroColor: String // hex for placeholder gradient
    var dishes: [Dish]
    var reviews: [Review]
    var isFavorite: Bool
    var openingHours: String
    var priceLevel: PriceLevel
    var instagramHandle: String?

    init(
        id: UUID = UUID(),
        name: String,
        city: String,
        address: String,
        distance: Double,
        rating: Double,
        reviewCount: Int,
        viralSource: ViralSource,
        categories: [CafeCategory],
        whyViral: String,
        coordinate: CLLocationCoordinate2D,
        heroColor: String,
        dishes: [Dish] = [],
        reviews: [Review] = [],
        isFavorite: Bool = false,
        openingHours: String = "Mo–So: 08:00–20:00",
        priceLevel: PriceLevel = .medium,
        instagramHandle: String? = nil
    ) {
        self.id = id
        self.name = name
        self.city = city
        self.address = address
        self.distance = distance
        self.rating = rating
        self.reviewCount = reviewCount
        self.viralSource = viralSource
        self.categories = categories
        self.whyViral = whyViral
        self.coordinate = coordinate
        self.heroColor = heroColor
        self.dishes = dishes
        self.reviews = reviews
        self.isFavorite = isFavorite
        self.openingHours = openingHours
        self.priceLevel = priceLevel
        self.instagramHandle = instagramHandle
    }

    var distanceFormatted: String {
        distance < 1.0 ? String(format: "%.0f m", distance * 1000) : String(format: "%.1f km", distance)
    }

    var ratingFormatted: String {
        String(format: "%.1f", rating)
    }
}

enum ViralSource: String, CaseIterable {
    case tiktok = "Viral auf TikTok"
    case instagram = "Viral auf Instagram"
    case both = "Viral auf TikTok & Instagram"

    var icon: String {
        switch self {
        case .tiktok: return "play.circle.fill"
        case .instagram: return "camera.fill"
        case .both: return "flame.fill"
        }
    }

    var shortLabel: String {
        switch self {
        case .tiktok: return "TikTok"
        case .instagram: return "Instagram"
        case .both: return "TikTok & IG"
        }
    }
}

enum CafeCategory: String, CaseIterable, Identifiable {
    case aesthetic = "Aesthetic"
    case brunch = "Brunch"
    case sweets = "Süßspeisen"
    case rooftop = "Rooftop"
    case quiet = "Ruhig"
    case studyFriendly = "Zum Lernen"
    case cozy = "Cozy"
    case outdoor = "Outdoor"
    case instagrammable = "Instagrammable"
    case vintage = "Vintage"
    case familyFriendly = "Familien"
    case petFriendly = "Hunde"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .aesthetic: return "sparkles"
        case .brunch: return "fork.knife"
        case .sweets: return "birthday.cake.fill"
        case .rooftop: return "building.2.fill"
        case .quiet: return "moon.stars.fill"
        case .studyFriendly: return "book.fill"
        case .cozy: return "house.fill"
        case .outdoor: return "leaf.fill"
        case .instagrammable: return "camera.fill"
        case .vintage: return "clock.fill"
        case .familyFriendly: return "figure.2.and.child.holdinghands"
        case .petFriendly: return "pawprint.fill"
        }
    }
}

enum PriceLevel: String {
    case budget = "€"
    case medium = "€€"
    case upscale = "€€€"
}

struct Dish: Identifiable {
    let id: UUID
    var name: String
    var description: String
    var isViral: Bool
    var price: String
    var accentColor: String

    init(id: UUID = UUID(), name: String, description: String, isViral: Bool = false, price: String, accentColor: String = "C4956A") {
        self.id = id
        self.name = name
        self.description = description
        self.isViral = isViral
        self.price = price
        self.accentColor = accentColor
    }
}

struct Review: Identifiable {
    let id: UUID
    var authorName: String
    var authorInitial: String
    var rating: Double
    var text: String
    var date: Date
    var avatarColor: String

    init(id: UUID = UUID(), authorName: String, rating: Double, text: String, date: Date = Date(), avatarColor: String = "C4956A") {
        self.id = id
        self.authorName = authorName
        self.authorInitial = String(authorName.prefix(1))
        self.rating = rating
        self.text = text
        self.date = date
        self.avatarColor = avatarColor
    }
}
