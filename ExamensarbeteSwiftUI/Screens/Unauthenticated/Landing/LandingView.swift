import SwiftUI

struct LandingView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var isAnimating: Bool = false

    var body: some View {
        ZStack {
            BackgroundMain(title: "")
            Text("Welcome to Touhou Siege")
                .font(TouhouSiegeStyle.FontSize.ultra.bold())
                .foregroundStyle(.ultraThinMaterial)
                .offset(y: -width * TouhouSiegeStyle.Decimals.xLarge)
            
            VStack {
                Spacer()
                
                ButtonMedium(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .login)
                    })
                }, text: "Login")
                
                ButtonMedium(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .register)
                    })
                }, text: "Register")
                
                ButtonMedium(function: {
                    withAnimation(.easeInOut(duration: TouhouSiegeStyle.BigDecimals.xSmall)) {
                        isAnimating = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + TouhouSiegeStyle.BigDecimals.xSmall, execute: {
                        navigationManager.navigateTo(screen: .about)
                    })
                }, text: "About")
            }
            .offset(y: -width * TouhouSiegeStyle.Decimals.medium)
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
