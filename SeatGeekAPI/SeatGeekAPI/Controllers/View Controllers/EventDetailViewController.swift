//
//  EventDetailViewController.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit
import SafariServices

class EventDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var ticketButton: UIButton!
    
    // MARK: - Properties
    var event: Event?

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        FavoriteController.shared.loadFromPersistentStorage()
    }
    
    // MARK: - Actions
    
    @IBAction func ticketButtonTapped(_ sender: Any) {
        guard let event = event else {return}
        if let url = event.url {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        } else {
            presentAlert()
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let event = event else {return}
        if event.isFavorite() {
            favoriteButton.image = UIImage(systemName: "heart")
            FavoriteController.shared.removeFavorite(event: event)
        } else {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            FavoriteController.shared.addToFavorites(event: event)
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let event = event else {return}
        eventTitleLabel.text = event.title
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
        ticketButton.layer.cornerRadius = 8
        eventImageView.image = ImageCache.shared.object(forKey: event.performers[0].image as NSURL)
        eventDateLabel.text = event.date.toDate().dateToString(format: .full)
        eventLocationLabel.text = event.venue.location
        if event.isFavorite() {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Whoops", message: "Link for this event not available", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
