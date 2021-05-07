//
//  RequestingImageView.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 5/6/21.
//

import UIKit

class ImageCache {
    static var shared = NSCache<NSURL, UIImage>()
}

class RequestingImageView: UIImageView {
    func fetchAndSetImage(with url: URL) {
        if let image = ImageCache.shared.object(forKey: NSURL(string: url.absoluteString) ?? NSURL()) {
            self.image = image
            self.formatImage()
        } else {
            let urlRequest = URLRequest(url: url)
            EventService().perform(urlRequest: urlRequest) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.image = image
                    self?.formatImage()
                    if let cacheImage = image {
                        ImageCache.shared.setObject(cacheImage, forKey: NSURL(string: url.absoluteString) ?? NSURL())
                    }
                case .failure(let error):
                    print("Error in \(#function) -\n\(#file):\(#line) -\n\(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    private func formatImage() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.addCornerRadius()
    }
}
