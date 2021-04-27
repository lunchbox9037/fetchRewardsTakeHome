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
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case title, performers
        case date = "datetime_local"
    }
}

struct Performer: Decodable {
    let image: String
}
