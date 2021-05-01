//
//  EventTableViewCell.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Methods
    func setup(event: Event) {
        hideOrShowFavButton(event: event)
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.venue.location
        eventDateLabel.text = event.date.toDate().dateToString(format: .full)
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
        ImageService().fetchImage(event.performers[0].image) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.eventImageView.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.eventImageView.image = UIImage(systemName: "photo")
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func hideOrShowFavButton(event: Event) {
        if event.isFavorite() {
            favoriteButton.isHidden = false
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.isHidden = true
        }
    }
}
