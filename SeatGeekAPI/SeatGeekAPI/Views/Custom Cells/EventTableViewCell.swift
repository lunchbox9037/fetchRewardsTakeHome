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
    
    // MARK: - Methods
    func setup(event: Event) {
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.venue.location
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        let formattedDate = formatter.date(from: event.date)
//        print(event.date)
        let date = event.date.toDate()

        
        eventDateLabel.text = date.dateToString(format: .full)
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
                print(error.localizedDescription)
            }
        }
    }
}
