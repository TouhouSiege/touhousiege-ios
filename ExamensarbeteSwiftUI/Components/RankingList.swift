//
//  RankingList.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-26.
//

import SwiftUI

struct RankingList: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var apiAuthManager: ApiAuthManager
    @EnvironmentObject var userManager: UserManager
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    @State var users: [User] = []
    
    var body: some View {
        ZStack {
            VStack {
                Text("Rankings")
                    .font(TouhouSiegeStyle.FontSize.xLarge.bold())
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                    .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                
                HStack {
                    Text("Name")
                    Text("Wins")
                    Text("Losses")
                    Text("Win %")
                }
                .font(TouhouSiegeStyle.FontSize.small.bold())
                .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                .offset(y: width * TouhouSiegeStyle.Decimals.xSmall)
                
                Spacer()
                
                ForEach(users.sorted {
                    Double($0.pvpWins) / Double($0.pvpWins + $0.pvpLosses) >
                    Double($1.pvpWins) / Double($1.pvpWins + $1.pvpLosses)
                }, id: \.id) { user in
                    HStack {
                        Text(user.username)
                        Text("\(user.pvpWins)")
                        Text("\(user.pvpLosses)")
                        if user.pvpWins + user.pvpLosses == 0 {
                            Text("0%")
                        } else {
                            Text("\((user.pvpWins) / (user.pvpWins + user.pvpLosses) * 100)%")
                        }
                    }
                    .font(TouhouSiegeStyle.FontSize.medium)
                    .foregroundStyle(Color(TouhouSiegeStyle.Colors.brownLight))
                }


                Spacer()
            }
            .frame(maxWidth: width * TouhouSiegeStyle.BigDecimals.small, maxHeight: height * TouhouSiegeStyle.BigDecimals.Large)
            .background {
                RoundedRectangle(cornerRadius: TouhouSiegeStyle.CornerRadius.small)
                    .fill(Color(TouhouSiegeStyle.Colors.brownGeneral).opacity(TouhouSiegeStyle.BigDecimals.xxxLarge))
                    .stroke(Color(TouhouSiegeStyle.Colors.brownLight), lineWidth: TouhouSiegeStyle.StrokeWidth.xSmall)
            }
        }.task {
                do {
                    let response = try await apiAuthManager.getAllPlayers()
                    
                    if response.success {
                        users.append(contentsOf: response.user)
                        print("Successfully appeded users!")
                    }
                } catch let error {
                    print("Error loading user: \(error)")
                }
       
        }
    }
}

#Preview {
    RankingList()
}
