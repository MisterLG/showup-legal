import SwiftUI

// MARK: - Color Palette
extension Color {
    static let fBackground    = Color(hex: "F5EDE0")
    static let fCard          = Color(hex: "FDFAF6")
    static let fPrimary       = Color(hex: "3D2314")
    static let fAccent        = Color(hex: "C4956A")
    static let fAccentLight   = Color(hex: "E8D5C4")
    static let fSecondary     = Color(hex: "8B6355")
    static let fMuted         = Color(hex: "B0998A")
    static let fDivider       = Color(hex: "E8DDD4")
    static let fViralRed      = Color(hex: "E8614B")
    static let fStarYellow    = Color(hex: "F4C430")

    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Typography
extension Font {
    static let fDisplay    = Font.custom("Georgia", size: 32).weight(.bold)
    static let fTitle      = Font.custom("Georgia", size: 24).weight(.semibold)
    static let fTitle2     = Font.custom("Georgia", size: 20).weight(.semibold)
    static let fHeadline   = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let fBody       = Font.system(size: 14, weight: .regular, design: .rounded)
    static let fBodyMed    = Font.system(size: 14, weight: .medium, design: .rounded)
    static let fCaption    = Font.system(size: 12, weight: .regular, design: .rounded)
    static let fCaptionMed = Font.system(size: 12, weight: .medium, design: .rounded)
    static let fMicro      = Font.system(size: 10, weight: .medium, design: .rounded)
}

// MARK: - Card Style
struct FancisCardModifier: ViewModifier {
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(Color.fCard)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.fPrimary.opacity(0.08), radius: 12, x: 0, y: 4)
    }
}

extension View {
    func fancisCard(padding: CGFloat = 16) -> some View {
        modifier(FancisCardModifier(padding: padding))
    }
}

// MARK: - Pill / Chip Style
struct FancisPillModifier: ViewModifier {
    var filled: Bool = false

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(filled ? Color.fAccent : Color.fAccentLight)
            .clipShape(Capsule())
    }
}

extension View {
    func fancisPill(filled: Bool = false) -> some View {
        modifier(FancisPillModifier(filled: filled))
    }
}
