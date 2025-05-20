import SwiftUI

struct NavigationScreenManager {
    static func viewForScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .game(var isComputerPlaying):
            return AnyView(GameView(isComputerPlaying: isComputerPlaying))
        case .home:
            return AnyView(HomeView())
        case .landing:
            return AnyView(LandingView())
        case .login:
            return AnyView(LoginView())
        case .gacha:
            return AnyView(GachaView())
        case .purchaseCrystal:
            return AnyView(PurchaseCrystalView())
        case .about:
            return AnyView(AboutView())
        case .characters:
            return AnyView(CharactersView())
        case .shop:
            return AnyView(ShopView())
        case .register:
            return AnyView(RegisterView())
        case .settings:
            return AnyView(SettingsView())
        case .play:
            return AnyView(PlayView())
        case .defense:
            return AnyView(DefenseView())
        }
    }
}
