import Foundation
import CoreLocation

struct MockData {
    static let cafes: [Cafe] = [
        Cafe(
            name: "EL&N Café",
            city: "München",
            address: "Maximilianstraße 12, 80539 München",
            distance: 1.2,
            rating: 4.8,
            reviewCount: 1247,
            viralSource: .tiktok,
            categories: [.aesthetic, .instagrammable, .brunch, .sweets],
            whyViral: "Bekannt für den pinken Style, leckere Lattes & den perfekten Instagram Spot ✨ Hunderte TikTok-Videos wurden hier gedreht.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1391, longitude: 11.5802),
            heroColor: "F2C4CE",
            dishes: [
                Dish(name: "Rose Latte", description: "Cremiger Latte mit Rosensirup & Goldflitter", isViral: true, price: "6,50 €", accentColor: "F2C4CE"),
                Dish(name: "Strawberry Matcha", description: "Japanischer Matcha mit frischen Erdbeeren", isViral: true, price: "7,00 €", accentColor: "A8C5A0"),
                Dish(name: "EL&N Pancakes", description: "Fluffige Pancakes mit Erdbeeren & Sahne", isViral: false, price: "14,50 €", accentColor: "F5DEB3"),
                Dish(name: "Iced Brown Sugar Oat", description: "Cold Brew mit braunem Zucker & Haferdrink", isViral: true, price: "6,80 €", accentColor: "C4956A")
            ],
            reviews: [
                Review(authorName: "Lena M.", rating: 5.0, text: "Absolut traumhaft! Die Rose Latte ist ein Muss. Der Laden ist so schön dekoriert, perfekt für Fotos!", date: Date().addingTimeInterval(-86400 * 2), avatarColor: "F2C4CE"),
                Review(authorName: "Sophie K.", rating: 4.5, text: "Tolle Atmosphäre und leckere Getränke. Etwas teuer aber definitiv seinen Preis wert.", date: Date().addingTimeInterval(-86400 * 7), avatarColor: "C4956A"),
                Review(authorName: "Julia R.", rating: 5.0, text: "Ich bin wegen TikTok hierhergekommen und war nicht enttäuscht! Unbedingt die Pancakes probieren.", date: Date().addingTimeInterval(-86400 * 14), avatarColor: "8B6355")
            ],
            isFavorite: true,
            openingHours: "Mo–So: 08:00–21:00",
            priceLevel: .upscale,
            instagramHandle: "@elnlondon"
        ),
        Cafe(
            name: "Café Jasmin",
            city: "München",
            address: "Steinheilstraße 20, 80333 München",
            distance: 0.8,
            rating: 4.6,
            reviewCount: 892,
            viralSource: .instagram,
            categories: [.vintage, .cozy, .quiet, .studyFriendly],
            whyViral: "Vintage-Charme der 1950er trifft auf exzellenten Filterkaffee. Ein Münchner Kultcafé, das seit Jahrzehnten begeistert.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1481, longitude: 11.5625),
            heroColor: "D4B896",
            dishes: [
                Dish(name: "Einspänner", description: "Wiener Mokka mit Schlagobers – klassisch & perfekt", isViral: true, price: "4,80 €", accentColor: "8B6355"),
                Dish(name: "Nussschnecke", description: "Hausgemachte Schnecke mit Walnuss-Füllung", isViral: false, price: "4,20 €", accentColor: "C4956A"),
                Dish(name: "Milchkaffee mit Schaum", description: "Extra cremig, in der Retro-Tasse serviert", isViral: true, price: "5,50 €", accentColor: "D4B896")
            ],
            reviews: [
                Review(authorName: "Max B.", rating: 5.0, text: "Das beste Café in München! Die Atmosphäre ist einzigartig und der Kaffee fantastisch.", date: Date().addingTimeInterval(-86400 * 1), avatarColor: "8B6355"),
                Review(authorName: "Anna W.", rating: 4.5, text: "Perfekt zum Lernen oder Lesen. Ruhig, gemütlich und toller Kaffee.", date: Date().addingTimeInterval(-86400 * 5), avatarColor: "C4956A")
            ],
            openingHours: "Mo–Fr: 09:00–19:00, Sa–So: 10:00–18:00",
            priceLevel: .medium,
            instagramHandle: "@cafejasmin_muc"
        ),
        Cafe(
            name: "Kaffeerösterei Markt Schwaben",
            city: "München",
            address: "Viktualienmarkt 6, 80331 München",
            distance: 1.9,
            rating: 4.7,
            reviewCount: 634,
            viralSource: .both,
            categories: [.outdoor, .brunch, .cozy],
            whyViral: "Direkter Röster mit Blick auf den Viktualienmarkt. Der Flat White hat auf TikTok viral 2M Views gesammelt.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1350, longitude: 11.5765),
            heroColor: "A0785A",
            dishes: [
                Dish(name: "Signature Flat White", description: "Hausgeröstet, doppelt gezogen – cremig & kräftig", isViral: true, price: "5,20 €", accentColor: "A0785A"),
                Dish(name: "Avocado Toast Deluxe", description: "Sauerteig, Avocado, Poached Egg & Chili-Flocken", isViral: true, price: "13,90 €", accentColor: "A8C5A0"),
                Dish(name: "Banana Bread", description: "Hausgemacht mit Walnüssen & Ahornsirup", isViral: false, price: "5,50 €", accentColor: "D4B896")
            ],
            reviews: [
                Review(authorName: "Tom H.", rating: 5.0, text: "Der beste Kaffee der Stadt, punkt! Der Flat White ist Wahnsinn.", date: Date().addingTimeInterval(-86400 * 3), avatarColor: "A0785A"),
                Review(authorName: "Clara F.", rating: 4.0, text: "Tolle Location direkt am Markt. Etwas laut, aber der Kaffee entschädigt alles.", date: Date().addingTimeInterval(-86400 * 9), avatarColor: "C4956A")
            ],
            openingHours: "Mo–Sa: 07:30–18:00, So: geschlossen",
            priceLevel: .medium
        ),
        Cafe(
            name: "Vits am Gärtnerplatz",
            city: "München",
            address: "Gärtnerplatz 2, 80469 München",
            distance: 2.4,
            rating: 4.5,
            reviewCount: 521,
            viralSource: .instagram,
            categories: [.outdoor, .aesthetic, .familyFriendly, .petFriendly],
            whyViral: "Legendärer Außenbereich am Gärtnerplatz. Im Sommer der meistfotografierte Café-Spot in München.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1298, longitude: 11.5761),
            heroColor: "B8D4B8",
            dishes: [
                Dish(name: "Aperol Spritz Latte", description: "Trendy Sommer-Drink: Espresso trifft Aperol-Note", isViral: true, price: "6,00 €", accentColor: "F4A460"),
                Dish(name: "Croissant au Beurre", description: "Frisch gebacken, buttrig & knusprig", isViral: false, price: "3,80 €", accentColor: "F5DEB3")
            ],
            reviews: [
                Review(authorName: "Nina S.", rating: 4.5, text: "Im Sommer unschlagbar! Die Terrasse ist ein Traum.", date: Date().addingTimeInterval(-86400 * 4), avatarColor: "B8D4B8")
            ],
            openingHours: "Mo–So: 08:00–22:00",
            priceLevel: .medium,
            instagramHandle: "@vits_gärtnerplatz"
        ),
        Cafe(
            name: "Cotidiano",
            city: "München",
            address: "Leopoldstraße 175, 80804 München",
            distance: 3.1,
            rating: 4.4,
            reviewCount: 1089,
            viralSource: .tiktok,
            categories: [.brunch, .instagrammable, .aesthetic],
            whyViral: "Das Brunch-Mekka Münchens. Jedes Wochenende ausgebucht, die Bowls gehen auf TikTok regelmäßig viral.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1622, longitude: 11.5808),
            heroColor: "E8D5C4",
            dishes: [
                Dish(name: "Açaí Bowl", description: "Cremige Açaí-Basis, Granola, frische Früchte & Honig", isViral: true, price: "11,50 €", accentColor: "9B59B6"),
                Dish(name: "Eggs Benedict", description: "Pochiertes Ei auf Toastmuffin mit Hollandaise", isViral: true, price: "15,90 €", accentColor: "F5DEB3"),
                Dish(name: "Matcha Latte", description: "Ceremonial Grade Matcha mit Oatly Haferdrink", isViral: false, price: "6,50 €", accentColor: "A8C5A0")
            ],
            reviews: [
                Review(authorName: "Marie L.", rating: 4.5, text: "Die Açaí Bowl ist absolut göttlich! Wir kommen jeden Sonntag her.", date: Date().addingTimeInterval(-86400 * 2), avatarColor: "9B59B6"),
                Review(authorName: "Felix G.", rating: 4.0, text: "Super Brunch-Spot, aber man sollte reservieren! Lange Wartezeiten ohne Reservierung.", date: Date().addingTimeInterval(-86400 * 10), avatarColor: "C4956A")
            ],
            openingHours: "Mo–Fr: 08:00–17:00, Sa–So: 09:00–17:00",
            priceLevel: .medium,
            instagramHandle: "@cotidiano_munich"
        ),
        Cafe(
            name: "Ruff's Burger & Bar",
            city: "München",
            address: "Amalienstraße 35, 80799 München",
            distance: 2.7,
            rating: 4.3,
            reviewCount: 445,
            viralSource: .tiktok,
            categories: [.cozy, .quiet, .studyFriendly],
            whyViral: "Geheimtipp: Das obere Stockwerk ist ein ruhiger Lese- und Arbeits-Spot mit bestem Filterkaffee.",
            coordinate: CLLocationCoordinate2D(latitude: 48.1510, longitude: 11.5725),
            heroColor: "C8B89A",
            dishes: [
                Dish(name: "Cold Brew Tonic", description: "Cold Brew über Tonic Water – erfrischend & wach", isViral: true, price: "5,80 €", accentColor: "C8B89A"),
                Dish(name: "Cheesecake Slice", description: "New York Style, täglich frisch", isViral: false, price: "6,20 €", accentColor: "F5DEB3")
            ],
            reviews: [
                Review(authorName: "David K.", rating: 4.5, text: "Perfekt zum Arbeiten! Gutes WLAN, ruhige Atmosphäre und top Kaffee.", date: Date().addingTimeInterval(-86400 * 6), avatarColor: "C8B89A")
            ],
            openingHours: "Mo–So: 10:00–23:00",
            priceLevel: .budget
        )
    ]
}
