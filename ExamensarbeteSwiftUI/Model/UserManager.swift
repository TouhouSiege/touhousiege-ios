//
//  UserManager.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-05-05.
//

import Foundation

class UserManager: ObservableObject {
    @Published var user: User?
    private var apiAuthManager: ApiAuthManager

    let api = Api()
    
    let BASE_URL = "http://localhost:8080/api/v1/user"
    
    init(apiAuthManager: ApiAuthManager) {
        self.apiAuthManager = apiAuthManager
    }
    
    func getUser() async throws {
        guard let username = apiAuthManager.username else {
            print("Error: Username is nil")
            return
        }

        print("\(BASE_URL)/\(username)")
        let fetchedUser: User = try await api.get(url: "\(BASE_URL)/\(username)", token: apiAuthManager.token)
        print("Fetched user: \(fetchedUser)")


        DispatchQueue.main.async {
            self.user = fetchedUser
        }
    }
}
