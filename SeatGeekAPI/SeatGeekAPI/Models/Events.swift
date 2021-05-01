//
//  Events.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import Foundation

struct Events: Codable {
    let events: [Event]
}

struct Event: Codable {
    let title: String
    let date: String
    let url: URL?
    let venue: Venue
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case title, performers, venue, url
        case date = "datetime_local"
    }
}

struct Performer: Codable {
    let image: URL
}

struct Venue: Codable {
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.title == rhs.title && lhs.date == rhs.date && lhs.venue.location == rhs.venue.location
    }
}

extension Event {
    func isFavorite() -> Bool {
        return FavoriteController.shared.favs.contains(self)
    }
}
