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
    
    // MARK: - Properties
    private var viewModel = EventListViewModel()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
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
        FavoriteController.shared.loadFromPersistentStorage()
        eventListTableView.reloadData()
    }

    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = eventListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else {return}
            let eventToSend = viewModel.events[indexPath.row]
            destination.viewModel = eventToSend
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
        
        cell.setupCell(with: viewModel.events[indexPath.row])
        return cell
    }
}

extension EventListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        title = searchText
        viewModel.searchEvents(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        title = "Today's Events"
        viewModel.fetchEvents()
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}//end extensions
