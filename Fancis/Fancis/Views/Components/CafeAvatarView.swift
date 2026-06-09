import SwiftUI

// Gradient placeholder shown until real images are loaded
struct CafeAvatarView: View {
    let cafe: Cafe
    var size: CGFloat = 56
    var showBorder: Bool = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: cafe.heroColor),
                    Color(hex: cafe.heroColor).opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: size * 0.38))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            showBorder ?
            Circle().strokeBorder(Color.white, lineWidth: 2.5) : nil
        )
    }
}

// Larger hero image placeholder for detail view
struct CafeHeroView: View {
    let cafe: Cafe
    var height: CGFloat = 280

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [
                    Color(hex: cafe.heroColor),
                    Color(hex: cafe.heroColor).opacity(0.75),
                    Color.fPrimary.opacity(0.4)
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .frame(height: height)

            // Decorative pattern
            GeometryReader { geo in
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: geo.size.width * 0.7)
                    .offset(x: geo.size.width * 0.5, y: -geo.size.height * 0.2)

                Circle()
                    .fill(Color.white.opacity(0.04))
                    .frame(width: geo.size.width * 0.45)
                    .offset(x: -geo.size.width * 0.1, y: geo.size.height * 0.1)
            }

            // Centered icon
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.white.opacity(0.25))
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: height)
        .clipped()
    }
}

// Small square thumbnail
struct CafeThumbnailView: View {
    let cafe: Cafe
    var size: CGFloat = 80

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: cafe.heroColor), Color(hex: cafe.heroColor).opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: size * 0.35))
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
