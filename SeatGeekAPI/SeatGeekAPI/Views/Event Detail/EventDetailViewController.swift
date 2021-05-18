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
    @IBOutlet weak var eventImageView: RequestingImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var ticketButton: UIButton!
    
    // MARK: - Properties
    var viewModel: EventViewModel?

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func ticketButtonTapped(_ sender: Any) {
        guard let event = viewModel else {return}
        if let url = event.ticketURL {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        } else {
            presentAlert()
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let event = viewModel else {return}
        if event.event.isFavorite() {
            event.unfavorite()
            favoriteButton.image = UIImage(systemName: "heart")
        } else {
            event.favorite()
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let event = viewModel else {return}
        if event.event.isFavorite() {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
        eventTitleLabel.text = event.title
        eventDateLabel.text = event.date
        eventLocationLabel.text = event.location
        ticketButton.addCornerRadius()
        guard let url = event.imageURL else {return}
        eventImageView.fetchAndSetImage(with: url)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Whoops", message: "Link for this event not available", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
