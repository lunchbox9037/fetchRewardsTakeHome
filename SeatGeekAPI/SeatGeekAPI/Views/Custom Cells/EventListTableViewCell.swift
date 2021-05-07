//
//  EventTableViewCell.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var eventImageView: RequestingImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    static let identifier = "eventCell"
    
    // MARK: - Methods
    func setupCell(with event: EventViewModel) {
        eventTitleLabel.text = event.title
        eventLocationLabel.text  = event.location
        eventDateLabel.text = event.date
        if !event.isFavoriteEvent {
            favoriteButton.isHidden = true
        } else {
            favoriteButton.isHidden = false
        }
        
        guard let url = event.imageURL else {return}
        eventImageView.fetchAndSetImage(with: url)
    }
}
