//
//  EventViewModel.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 5/6/21.
//
 
import Foundation
import Combine

class EventListViewModel: ObservableObject {
    private let eventService = EventService()
    @Published var events = [EventViewModel]()
    
    func fetchFavorites() {
        events = FavoriteController.shared.favs.compactMap({EventViewModel(event: $0)})
    }
    
    func fetchEvents() {
        eventService.fetch(.events) { [weak self] (result: Result<Events, NetError>) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self?.events = results.events.compactMap({EventViewModel(event: $0)})
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchEvents(searchText: String) {
        eventService.fetch(.search(searchText)) { [weak self] (result: Result<Events, NetError>) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self?.events = results.events.compactMap({EventViewModel(event: $0)})
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

