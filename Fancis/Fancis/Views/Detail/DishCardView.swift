import SwiftUI

struct DishCardView: View {
    let dish: Dish

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Dish image placeholder
            ZStack(alignment: .topLeading) {
                LinearGradient(
                    colors: [Color(hex: dish.accentColor), Color(hex: dish.accentColor).opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 110)

                Image(systemName: "fork.knife")
                    .font(.system(size: 36))
                    .foregroundColor(.white.opacity(0.35))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if dish.isViral {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 9, weight: .bold))
                        Text("Viral")
                            .font(.fMicro)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.fViralRed)
                    .clipShape(Capsule())
                    .padding(8)
                }
            }
            .frame(height: 110)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(dish.name)
                    .font(.fBodyMed)
                    .foregroundColor(.fPrimary)
                    .lineLimit(1)

                Text(dish.description)
                    .font(.fCaption)
                    .foregroundColor(.fMuted)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 6)

                Text(dish.price)
                    .font(.fCaptionMed)
                    .foregroundColor(.fAccent)
            }
            .padding(12)
            .frame(height: 100)
        }
        .frame(width: 160)
        .background(Color.fCard)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.fPrimary.opacity(0.08), radius: 8, x: 0, y: 3)
    }
}
