import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                ButtonMainMenu(function: {
                    navigationManager.navigate(to: .game)
                }, text: "TestButton")
                
                ButtonMainMenu(function: {
                    navigationManager.navigate(to: .login)
                }, text: "LoginScreen")
                
                ButtonMainMenu(function: {
                    navigationManager.navigate(to: .markdownsaur)
                }, text: "Markdownsaur")
            }
        }
    }
}

func checkForLetters(comment: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[A-Za-z ]*$", options: [])
    let boolCheck = regex.firstMatch(in: comment, options: [], range: NSMakeRange(0, comment.utf16.count)) != nil
    
    return boolCheck
}

#Preview {
    HomeScreen().environmentObject(NavigationManager())
}
