import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: CafeViewModel
    @State private var showEditProfile = false
    @AppStorage("userName") private var userName: String = "Café-Entdecker"
    @AppStorage("userCity") private var userCity: String = "München"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    profileHeader
                    statsRow
                    settingsSection
                }
                .padding(.bottom, 40)
            }
            .background(Color.fBackground.ignoresSafeArea())
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 14) {
            // Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.fAccent, Color.fSecondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)

                Text(String(userName.prefix(1)))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .shadow(color: Color.fAccent.opacity(0.3), radius: 12, x: 0, y: 6)

            VStack(spacing: 4) {
                Text(userName)
                    .font(.fTitle2)
                    .foregroundColor(.fPrimary)
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.fAccent)
                        .font(.system(size: 13))
                    Text(userCity)
                        .font(.fBody)
                        .foregroundColor(.fMuted)
                }
            }

            Button {
                showEditProfile = true
            } label: {
                Text("Profil bearbeiten")
                    .font(.fBodyMed)
                    .foregroundColor(.fAccent)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.fAccentLight)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 20)
        .padding(.bottom, 24)
    }

    private var statsRow: some View {
        HStack(spacing: 0) {
            statCell(value: "\(vm.favoriteCafes.count)", label: "Favoriten", icon: "bookmark.fill")
            Divider().frame(height: 40)
            statCell(value: "\(vm.cafes.reduce(0) { $0 + $1.reviews.count })", label: "Rezensionen", icon: "star.fill")
            Divider().frame(height: 40)
            statCell(value: "12", label: "Entdeckt", icon: "binoculars.fill")
        }
        .fancisCard()
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }

    private func statCell(value: String, label: String, icon: String) -> some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(.fAccent)
            Text(value)
                .font(.fTitle2)
                .foregroundColor(.fPrimary)
            Text(label)
                .font(.fMicro)
                .foregroundColor(.fMuted)
        }
        .frame(maxWidth: .infinity)
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Einstellungen")
                .font(.fHeadline)
                .foregroundColor(.fPrimary)
                .padding(.horizontal, 20)

            VStack(spacing: 0) {
                settingsRow(icon: "bell.fill", label: "Benachrichtigungen", color: Color(hex: "F4A460"))
                Divider().padding(.leading, 56)
                settingsRow(icon: "location.fill", label: "Standort", color: Color(hex: "5B9BD5"))
                Divider().padding(.leading, 56)
                settingsRow(icon: "globe", label: "Sprache", color: Color(hex: "58C389"))
                Divider().padding(.leading, 56)
                settingsRow(icon: "lock.shield.fill", label: "Datenschutz", color: Color(hex: "9B7EBD"))
                Divider().padding(.leading, 56)
                settingsRow(icon: "star.fill", label: "App bewerten", color: Color.fStarYellow)
                Divider().padding(.leading, 56)
                settingsRow(icon: "info.circle.fill", label: "Über Fancis", color: .fAccent)
            }
            .fancisCard(padding: 0)
            .padding(.horizontal, 16)
        }
    }

    private func settingsRow(icon: String, label: String, color: Color) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
            }
            Text(label)
                .font(.fBody)
                .foregroundColor(.fPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.fMuted)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
}
