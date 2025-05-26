import SwiftUI

struct LandingView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    
    @State var isAnimating: Bool = false

    var body: some View {
        ZStack {
            BackgroundMain(title: "Welcome to \nTouhou Siege")
            
            VStack {
                ButtonBig(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .login)
                    })
                }, text: "Login")
                
                ButtonBig(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .register)
                    })
                }, text: "Register")
                
                ButtonBig(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .about)
                    })
                }, text: "About")
            }
            .opacity(isAnimating ? 0 : 1)
        }.onAppear {
                isAnimating = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.Decimals.xSmall, execute: {
                    isAnimating = false
                })
            
            if apiAuthManager.token != nil && apiAuthManager.username != nil {
                navigationManager.navigateTo(screen: .home)
            }
        }
        .disabled(isAnimating)
        
    }
}

#Preview {
    LandingView().environmentObject(NavigationManager())
}
