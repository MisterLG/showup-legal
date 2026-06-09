import SwiftUI
import MapKit

struct CafeAnnotation: Identifiable {
    let id: UUID
    let cafe: Cafe
    var coordinate: CLLocationCoordinate2D { cafe.coordinate }
}

struct CafeMapPinView: View {
    let cafe: Cafe
    var isSelected: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Shadow ring
                Circle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: isSelected ? 62 : 50, height: isSelected ? 62 : 50)
                    .shadow(color: Color.fPrimary.opacity(0.25), radius: isSelected ? 10 : 6, x: 0, y: 3)

                // Outer ring (accent color when selected)
                Circle()
                    .fill(isSelected ? Color.fAccent : Color.white)
                    .frame(width: isSelected ? 58 : 46, height: isSelected ? 58 : 46)

                // Café avatar
                CafeAvatarView(cafe: cafe, size: isSelected ? 50 : 38, showBorder: false)

                // Viral flame badge
                if cafe.viralSource != .instagram {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color.fViralRed)
                                    .frame(width: 16, height: 16)
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: isSelected ? 58 : 46, height: isSelected ? 58 : 46)
                }
            }

            // Pointer triangle
            Triangle()
                .fill(isSelected ? Color.fAccent : Color.white)
                .frame(width: 14, height: 8)
                .shadow(color: Color.fPrimary.opacity(0.1), radius: 2, x: 0, y: 2)

            Spacer(minLength: 0)
        }
        .frame(width: isSelected ? 62 : 50, height: isSelected ? 72 : 58)
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSelected)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
}
