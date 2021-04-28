//
//  EventDetailViewController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    // MARK: - Properties
    var event: Event?

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let event = event else {return}
        
        if let favorites = UserDefaults.standard.stringArray(forKey: FavoriteController.favoriteKey) {
            if favorites.contains(event.title) {
                favoriteButton.image = UIImage(systemName: "heart")
                FavoriteController.shared.removeFavorite(event: event.title)
            } else {
                favoriteButton.image = UIImage(systemName: "heart.fill")
                FavoriteController.shared.addToFavorites(event: event.title)
            }
        } else {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            FavoriteController.shared.addToFavorites(event: event.title)
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let event = event else {return}
        title = event.title
        adjustLargeTitleSize()
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
        eventImageView.image = ImageCache.shared.object(forKey: event.performers[0].image as NSURL)
        let date = event.date.toDate()
        eventDateLabel.text = date.dateToString(format: .full)
        eventLocationLabel.text = event.venue.location
        if let favorites = UserDefaults.standard.stringArray(forKey: FavoriteController.favoriteKey) {
            if favorites.contains(event.title) {
                favoriteButton.image = UIImage(systemName: "heart.fill")
            }
        }
    }
}
