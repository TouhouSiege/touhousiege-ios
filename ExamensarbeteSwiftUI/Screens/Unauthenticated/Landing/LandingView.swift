import SwiftUI

struct LandingView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager

    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .login)
                }, text: "Login")
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .register)
                }, text: "Register")
                
                ButtonBig(function: {
                    navigationManager.navigateTo(screen: .about)
                }, text: "About")
            }
        }.onAppear {
            if apiAuthManager.token != nil && apiAuthManager.username != nil {
                navigationManager.navigateTo(screen: .home)
            }
        }
    }
}

#Preview {
    LandingView().environmentObject(NavigationManager())
}
