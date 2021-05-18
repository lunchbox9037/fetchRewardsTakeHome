//
//  EventListViewController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit
import Combine

class EventListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var eventListTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: - Properties
    private var viewModel = EventListViewModel()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        FavoriteController.shared.loadFromPersistentStorage()
        viewModel.fetchEvents()
        viewModel.$events
            .receive(on: RunLoop.main)
            .sink { (_) in
                self.eventListTableView.reloadData()
            }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        eventListTableView.reloadData()
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            title = "Today's Events"
            viewModel.fetchEvents()
        case 1:
            if searchBar.isFirstResponder {
                searchBar.text = nil
                segmentControl.setTitle("Today's Events", forSegmentAt: 0)
                searchBar.resignFirstResponder()
            }
            title = "Favorites"
            viewModel.fetchFavorites()
        default:
            return
        }
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = eventListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else {return}
            let eventToSend = viewModel.events[indexPath.row]
            destination.viewModel = eventToSend
            
            eventListTableView.deselectRow(at: indexPath, animated: false)
        }
    }
}//end class

// MARK: - Extensions
extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier, for: indexPath) as? EventListTableViewCell
        else {return UITableViewCell()}
        cell.delegate = self
        cell.event = viewModel.events[indexPath.row].event
        return cell
    }
}

extension EventListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        title = searchText
        segmentControl.setTitle("Search Results", forSegmentAt: 0)
        segmentControl.selectedSegmentIndex = 0
        viewModel.searchEvents(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        title = "Today's Events"
        segmentControl.setTitle("Today's Events", forSegmentAt: 0)
        segmentControlChanged(segmentControl)
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}

extension EventListViewController: FavoriteButtonDelegate {
    func toggleFavorite(_ sender: EventListTableViewCell) {
        guard let event = sender.event else {return}
        
        if event.isFavorite() {
            sender.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            FavoriteController.shared.removeFavorite(event: event)
        } else {
            sender.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            FavoriteController.shared.addToFavorites(event: event)
        }
        
        if segmentControl.selectedSegmentIndex == 1 {
            viewModel.fetchFavorites()
        }
    }
}
