//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 25.09.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkErrors>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkErrors>) -> Void) {
        let endpoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidRequest))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
         
            do {
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
