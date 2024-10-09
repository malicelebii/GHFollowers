//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 9.10.2024.
//

import Foundation

enum PersistanceManager {
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    enum ActionType {
        case add
        case remove
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], PersistanceErrors>) -> Void) {
        guard let favorites = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favorites)
            completion(.success(favorites))
        } catch {
            completion(.failure(.decodingError))
        }
    }
    
    static func saveFavorite(_ favorites: [Follower], completion: @escaping (Result<Bool, PersistanceErrors>) -> ()) {
        do {
            let encoder = JSONEncoder()
            let favorites = try encoder.encode(favorites)
            defaults.set(favorites, forKey: Keys.favorites)
            completion(.success(true))
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    static func updateWith(favorite: Follower, actionType: ActionType, completion: @escaping (Result<Bool, PersistanceErrors>) -> ()) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    if !retrievedFavorites.contains(favorite) {
                        retrievedFavorites.append(favorite)
                    }
                default:
                    if retrievedFavorites.contains(favorite), let index = retrievedFavorites.firstIndex(of: favorite) {
                        retrievedFavorites.remove(at: index)
                    }
                }
                
                saveFavorite(retrievedFavorites) { result in
                    if result == .success(true) {
                        completion(.success(true))
                    } else {
                        completion(.failure(.setError))
                    }
                }
            case .failure(let error):
                completion(.failure(.setError))
            }
        }
    }
}

