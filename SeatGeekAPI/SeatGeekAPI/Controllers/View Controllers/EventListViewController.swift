//
//  EventListViewController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class EventListViewController: UIViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    var events: [Event] = []
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    

    // MARK: - Methods
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

}//end class

// MARK: - Extensions
extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell
        else {return UITableViewCell()}
        //setupcell
        return cell
    }
}
