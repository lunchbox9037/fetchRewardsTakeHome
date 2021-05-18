//
//  EventTableViewCell.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

protocol FavoriteButtonDelegate: AnyObject {
    func toggleFavorite(_ sender: EventListTableViewCell)
}

class EventListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var eventImageView: RequestingImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    static let identifier = "eventCell"
    weak var delegate: FavoriteButtonDelegate?
    
    var event: Event? {
        didSet {
            guard let event = event else {return}
            setupCell(with: EventViewModel(event: event))
        }
    }
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavorite(self)
    }
    
    // MARK: - Methods
    func setupCell(with event: EventViewModel) {
        eventTitleLabel.text = event.title
        eventLocationLabel.text  = event.location
        eventDateLabel.text = event.date
        if !event.isFavoriteEvent {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.isHidden = false
        }
        
        guard let url = event.imageURL else {return}
        eventImageView.fetchAndSetImage(with: url)
    }
}
