//
//  EventListViewController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class EventListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var eventListTableView: UITableView!
    
    // MARK: - Properties
    var events: [Event] = []
    var results: [Event] = []
    var isSearching: Bool  = false
    var dataSource: [Event] {
        return isSearching ? results : events
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        searchBar.delegate = self
        fetchEvents()
    }
    
    // MARK: - Actions
    

    // MARK: - Methods
    func fetchEvents() {
        EventService().fetch(.events) { [weak self] (result: Result<Events, NetError>) in
            switch result {
            case .success(let results):
                self?.events = results.events
                DispatchQueue.main.async {
                    self?.eventListTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}//end class

// MARK: - Extensions
extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell
        else {return UITableViewCell()}
        cell.setup(event: dataSource[indexPath.row])
        return cell
    }
}

extension EventListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        results = events.filter { (event) -> Bool in
            return event.title.contains(searchText)
        }
        eventListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        results = events
        eventListTableView.reloadData()
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
