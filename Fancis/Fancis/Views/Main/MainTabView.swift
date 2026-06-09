import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var vm: CafeViewModel
    @State private var selectedTab: Tab = .discover

    enum Tab: Int {
        case discover, favorites, list, profile
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case .discover:   DiscoverView()
                case .favorites:  FavoritesView()
                case .list:       CafeListView()
                case .profile:    ProfileView()
                }
            }
            .environmentObject(vm)

            // Custom tab bar
            customTabBar
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            tabItem(tab: .discover,  icon: "map.fill",        label: "Entdecken")
            tabItem(tab: .favorites, icon: "heart.fill",      label: "Favoriten")
            tabItem(tab: .list,      icon: "list.bullet",     label: "Liste")
            tabItem(tab: .profile,   icon: "person.fill",     label: "Profil")
        }
        .padding(.horizontal, 8)
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Color.fCard
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.fPrimary.opacity(0.12), radius: 20, x: 0, y: -4)
        )
        .padding(.horizontal, 16)
    }

    private func tabItem(tab: Tab, icon: String, label: String) -> some View {
        let isSelected = selectedTab == tab
        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 5) {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.fAccentLight)
                            .frame(width: 46, height: 32)
                    }
                    Image(systemName: icon)
                        .font(.system(size: 19, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? .fAccent : .fMuted)
                }
                Text(label)
                    .font(.fMicro)
                    .foregroundColor(isSelected ? .fAccent : .fMuted)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
