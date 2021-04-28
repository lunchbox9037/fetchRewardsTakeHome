//
//  FavoriteController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import CoreData

class FavoriteController {
    static let shared = FavoriteController()
    static let favoriteKey = "favorites"
    
    // MARK: - CRUD
    func addToFavorites(event: String) {
        if var favorites = UserDefaults.standard.stringArray(forKey: FavoriteController.favoriteKey) {
            if !favorites.contains(event) {
                favorites.append(event)
                UserDefaults.standard.set(favorites, forKey: FavoriteController.favoriteKey)
            }
        } else {
            let favorites = [event]
            UserDefaults.standard.set(favorites, forKey: FavoriteController.favoriteKey)
        }
    }
    
    func removeFavorite(event: String) {
        guard var favorites = UserDefaults.standard.stringArray(forKey: FavoriteController.favoriteKey),
              let index = favorites.firstIndex(of: event) else { return }
        favorites.remove(at: index)
        UserDefaults.standard.set(favorites, forKey: FavoriteController.favoriteKey)
    }
}
