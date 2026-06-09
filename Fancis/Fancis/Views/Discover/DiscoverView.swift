import SwiftUI
import MapKit

struct DiscoverView: View {
    @EnvironmentObject var vm: CafeViewModel
    @EnvironmentObject var locationVM: LocationViewModel

    // Munich center as default
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.1391, longitude: 11.5802),
        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    )
    @State private var showSearch = false
    @State private var showDetail = false
    @State private var selectedCafe: Cafe? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            // MAP
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: vm.filteredCafes) { cafe in
                MapAnnotation(coordinate: cafe.coordinate) {
                    CafeMapPinView(cafe: cafe, isSelected: selectedCafe?.id == cafe.id)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4)) {
                                selectedCafe = cafe
                                centerMap(on: cafe)
                            }
                        }
                }
            }
            .ignoresSafeArea(edges: .top)

            // Top overlay: header + filters
            VStack(spacing: 0) {
                topBar
                filterTabs
                categoryRow
                Spacer()
            }

            // Bottom preview card
            if let cafe = selectedCafe {
                VStack(spacing: 0) {
                    Spacer()
                    CafePreviewCard(
                        cafe: cafe,
                        onTap: { showDetail = true },
                        onFavorite: { vm.toggleFavorite(cafe) }
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .sheet(isPresented: $showDetail) {
            if let cafe = selectedCafe {
                CafeDetailView(cafe: cafe)
                    .environmentObject(vm)
            }
        }
        .onAppear {
            locationVM.requestPermission()
        }
    }

    // MARK: - Subviews
    private var topBar: some View {
        HStack {
            // Search button
            Button {
                showSearch.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.fPrimary)
                    .frame(width: 40, height: 40)
                    .background(Color.fCard)
                    .clipShape(Circle())
                    .shadow(color: Color.fPrimary.opacity(0.1), radius: 8, x: 0, y: 2)
            }

            Spacer()

            Text("Fancis")
                .font(.fTitle2)
                .foregroundColor(.fPrimary)

            Spacer()

            // Filter button
            Button {
                vm.showFilters.toggle()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.fPrimary)
                    .frame(width: 40, height: 40)
                    .background(Color.fCard)
                    .clipShape(Circle())
                    .shadow(color: Color.fPrimary.opacity(0.1), radius: 8, x: 0, y: 2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 10)
        .background(
            LinearGradient(
                colors: [Color.fBackground, Color.fBackground.opacity(0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }

    private var filterTabs: some View {
        HStack(spacing: 8) {
            ForEach(FilterTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.35)) {
                        vm.selectedFilter = tab
                    }
                } label: {
                    HStack(spacing: 5) {
                        if tab == .viral {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 11))
                        } else if tab == .nearby {
                            Image(systemName: "location.fill")
                                .font(.system(size: 11))
                        } else {
                            Image(systemName: "sparkles")
                                .font(.system(size: 11))
                        }
                        Text(tab.rawValue)
                            .font(.fBodyMed)
                    }
                    .foregroundColor(vm.selectedFilter == tab ? .white : .fPrimary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 9)
                    .background(vm.selectedFilter == tab ? Color.fAccent : Color.fCard)
                    .clipShape(Capsule())
                    .shadow(color: Color.fPrimary.opacity(0.08), radius: 6, x: 0, y: 2)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }

    private var categoryRow: some View {
        CategoryScrollRow(selected: $vm.selectedCategory)
            .padding(.bottom, 6)
    }

    // MARK: - Helpers
    private func centerMap(on cafe: Cafe) {
        withAnimation {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: cafe.coordinate.latitude - 0.005,
                    longitude: cafe.coordinate.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
            )
        }
    }
}
