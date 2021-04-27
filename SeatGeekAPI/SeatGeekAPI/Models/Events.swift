//
//  Events.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import Foundation

struct Events: Decodable {
    let events: [Event]
}

struct Event: Decodable {
    let title: String
    let date: String
    let venue: Venue
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case title, performers, venue
        case date = "datetime_local"
    }
}

struct Performer: Decodable {
    let image: URL
}

struct Venue: Decodable {
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}
