import SwiftUI

struct LandingView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiViewModel: ApiViewModel

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
            if apiViewModel.token != nil {
                navigationManager.navigateTo(screen: .home)
            }
        }
    }
}

#Preview {
    LandingView().environmentObject(NavigationManager())
}
