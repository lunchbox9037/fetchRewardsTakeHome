//
//  RequestImageView.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 5/2/21.
//

import UIKit

class RequestingImageView: UIImageView {

    func fetchAndSetImage(from urlRequest: URLRequest) {
        EventService().perform(urlRequest: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self?.image = image
            case .failure(let error):
                print("Error in \(#function) -\n\(#file):\(#line) -\n\(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}
