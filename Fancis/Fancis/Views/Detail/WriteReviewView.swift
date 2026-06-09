import SwiftUI

struct WriteReviewView: View {
    let cafe: Cafe
    var onSubmit: (Review) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var authorName: String = ""
    @State private var rating: Double = 5
    @State private var text: String = ""
    @FocusState private var focusedField: Field?

    enum Field { case name, review }

    var canSubmit: Bool {
        !authorName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !text.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Café info
                    HStack(spacing: 14) {
                        CafeAvatarView(cafe: cafe, size: 50)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(cafe.name)
                                .font(.fHeadline)
                                .foregroundColor(.fPrimary)
                            Text(cafe.city)
                                .font(.fCaption)
                                .foregroundColor(.fMuted)
                        }
                    }
                    .padding(16)
                    .fancisCard(padding: 0)

                    // Rating selector
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deine Bewertung")
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                        InteractiveStarRating(rating: $rating)
                        Text(ratingLabel)
                            .font(.fBodyMed)
                            .foregroundColor(.fAccent)
                    }

                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dein Name")
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                        TextField("z.B. Lena M.", text: $authorName)
                            .font(.fBody)
                            .foregroundColor(.fPrimary)
                            .padding(14)
                            .background(Color.fCard)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(focusedField == .name ? Color.fAccent : Color.fDivider, lineWidth: 1.5)
                            )
                            .focused($focusedField, equals: .name)
                    }

                    // Review text
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deine Rezension")
                            .font(.fHeadline)
                            .foregroundColor(.fPrimary)
                        TextEditor(text: $text)
                            .font(.fBody)
                            .foregroundColor(.fPrimary)
                            .frame(minHeight: 120)
                            .padding(12)
                            .background(Color.fCard)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(focusedField == .review ? Color.fAccent : Color.fDivider, lineWidth: 1.5)
                            )
                            .focused($focusedField, equals: .review)

                        Text("\(text.count) / 500 Zeichen")
                            .font(.fMicro)
                            .foregroundColor(.fMuted)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    // Submit
                    Button {
                        let review = Review(
                            authorName: authorName.trimmingCharacters(in: .whitespaces),
                            rating: rating,
                            text: text.trimmingCharacters(in: .whitespaces),
                            date: Date()
                        )
                        onSubmit(review)
                        dismiss()
                    } label: {
                        Text("Rezension abschicken")
                            .font(.fHeadline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(canSubmit ? Color.fAccent : Color.fMuted)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .disabled(!canSubmit)
                    .buttonStyle(.plain)
                }
                .padding(20)
            }
            .background(Color.fBackground.ignoresSafeArea())
            .navigationTitle("Rezension schreiben")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { dismiss() }
                        .foregroundColor(.fAccent)
                }
            }
        }
    }

    private var ratingLabel: String {
        switch Int(rating) {
        case 5: return "Ausgezeichnet ✨"
        case 4: return "Sehr gut 😊"
        case 3: return "Gut 👍"
        case 2: return "Mittelmäßig"
        default: return "Enttäuschend"
        }
    }
}
