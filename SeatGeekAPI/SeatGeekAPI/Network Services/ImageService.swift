//
//  ImageService.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

class ImageCache {
    static var shared = NSCache<NSURL, UIImage>()
}

struct ImageService: NetworkServicing {
    func fetchImage(_ endpoint: URL, completion: @escaping (Result<UIImage, NetError>) -> Void) {
        
        if let poster = ImageCache.shared.object(forKey: NSURL(string: endpoint.absoluteString) ?? NSURL()) {
            completion(.success(poster))
        } else {
            perform(urlRequest: URLRequest(url: endpoint)) { (result) in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(.couldNotUnwrap))
                        return
                    }
                    ImageCache.shared.setObject(image, forKey: NSURL(string: endpoint.absoluteString) ?? NSURL())
                    return completion(.success(image))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }//end func
}//end class
