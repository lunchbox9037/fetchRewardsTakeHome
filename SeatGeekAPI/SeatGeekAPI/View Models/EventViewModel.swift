//
//  EventListTableViewCellViewModel.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 5/7/21.
//

import Foundation

class EventViewModel {
    let event: Event
    let title: String
    let date: String
    let location: String
    let imageURL: URL?
    let ticketURL: URL?
    var isFavoriteEvent: Bool = false

    init(event: Event) {
        self.event = event
        self.title = event.title
        self.date = event.date.toDate()?.dateToString(format: .full) ?? "TBD"
        self.location = event.venue.location
        self.imageURL = event.performers.first?.image
        self.ticketURL = event.url
        self.isFavoriteEvent = checkIsFavorite(event: event)
    }
    
    func favorite() {
        self.isFavoriteEvent = true
        FavoriteController.shared.addToFavorites(event: self.event)
    }
    
    func unfavorite() {
        self.isFavoriteEvent = false
        FavoriteController.shared.removeFavorite(event: self.event)
    }

    private func checkIsFavorite(event: Event) -> Bool {
        return event.isFavorite()
    }
}

