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
    var favs: [Event] = []
    
    // MARK: - CRUD
    func addToFavorites(event: Event) {
        favs.append(event)
        saveToPersistentStorage()
    }
    
    func removeFavorite(event: Event) {
        guard let index = favs.firstIndex(of: event) else {return}
        favs.remove(at: index)
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("SeatGeekAPI")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(favs)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            favs = try JSONDecoder().decode([Event].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
