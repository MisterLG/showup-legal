import SwiftUI

struct CategoryChipView: View {
    let category: CafeCategory
    var isSelected: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 5) {
                Image(systemName: category.icon)
                    .font(.system(size: 11, weight: .medium))
                Text(category.rawValue)
                    .font(.fCaptionMed)
            }
            .foregroundColor(isSelected ? .white : .fPrimary)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isSelected ? Color.fAccent : Color.fAccentLight)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(isSelected ? Color.clear : Color.fDivider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct CategoryScrollRow: View {
    @Binding var selected: CafeCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // All button
                Button {
                    withAnimation { selected = nil }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.system(size: 11, weight: .medium))
                        Text("Alle")
                            .font(.fCaptionMed)
                    }
                    .foregroundColor(selected == nil ? .white : .fPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(selected == nil ? Color.fAccent : Color.fAccentLight)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)

                ForEach(CafeCategory.allCases) { cat in
                    CategoryChipView(category: cat, isSelected: selected == cat) {
                        withAnimation {
                            selected = selected == cat ? nil : cat
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
