import SwiftUI

struct StarRatingView: View {
    let rating: Double
    var size: CGFloat = 12
    var color: Color = .fStarYellow

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: starImageName(for: star))
                    .font(.system(size: size))
                    .foregroundColor(color)
            }
        }
    }

    private func starImageName(for star: Int) -> String {
        let threshold = Double(star)
        if rating >= threshold {
            return "star.fill"
        } else if rating >= threshold - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

struct InteractiveStarRating: View {
    @Binding var rating: Double
    var size: CGFloat = 28

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: rating >= Double(star) ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundColor(.fStarYellow)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            rating = Double(star)
                        }
                    }
            }
        }
    }
}
