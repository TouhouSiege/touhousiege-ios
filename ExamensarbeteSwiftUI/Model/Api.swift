//
//  Api.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-29.
//

import Foundation

class Api {
    func post<T: Encodable, R: Decodable>(url: String, body: T?, token: String?) async throws -> R {
        guard let url = URL(string: url) else { throw APIErrors.invalidURL }
        
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST"
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw APIErrors.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 205 else { throw APIErrors.invalidResponse}
        
        let decoder = JSONDecoder()
        
        let responseString = String(data: data, encoding: .utf8)
        print("Raw Response: \(responseString ?? "No response data")")

        
        do {
            let decodedResponse = try decoder.decode(R.self, from: data)
            
            return decodedResponse
        } catch {
            throw APIErrors.invalidData
        }
    }
    
    func put<T: Encodable, R: Decodable>(url: String, body: T?, token: String?) async throws -> R {
        guard let url = URL(string: url) else { throw APIErrors.invalidURL }
        
        var request = URLRequest(url: url)
            
        request.httpMethod = "PUT"
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(body)
        } catch {
            throw APIErrors.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 205 else { throw APIErrors.invalidResponse}
        
        let decoder = JSONDecoder()
        
        do {
            let decodedResponse = try decoder.decode(R.self, from: data)
            
            return decodedResponse
        } catch {
            throw APIErrors.invalidData
        }
    }
    
    func get<R: Decodable>(url: String, token: String?) async throws -> R {
        guard let url = URL(string: url) else { throw APIErrors.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 205 else { throw APIErrors.invalidResponse}
        
        do {
            let decoder = JSONDecoder()
            
            let decodedResponse = try decoder.decode(R.self, from: data)
            
            return decodedResponse
        } catch {
            throw APIErrors.invalidData
        }
    }
}

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidRequest
}
