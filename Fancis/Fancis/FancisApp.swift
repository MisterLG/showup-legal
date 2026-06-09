import SwiftUI

@main
struct FancisApp: App {
    @StateObject private var cafeVM = CafeViewModel()
    @StateObject private var locationVM = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(cafeVM)
                .environmentObject(locationVM)
                .preferredColorScheme(.light)
        }
    }
}
