//
//  EventService.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import Foundation

enum EventEndPoint {
    static let baseURL = "https://api.seatgeek.com/2"
    static let clientID = "MjE3OTk4NzR8MTYxOTU0ODM2MC44NTg3Mzk0"

    case events
    
    var path: String {
        switch self {
        case .events:
            return "/events"
        }
    }
    
    var queryItems: [URLQueryItem] {
        let items = [
            URLQueryItem(name: "client_id", value: EventEndPoint.clientID)
        ]
        return items
    }
    
    var url: URL? {
        guard var url = URL(string: EventEndPoint.baseURL) else {return nil}
        url.appendPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url
    }
}
