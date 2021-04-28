//
//  LargeTitle+Extension.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import UIKit

extension UIViewController {
    func adjustLargeTitleSize() {
        guard let title = title, #available(iOS 11.0, *) else { return }
        
        let maxWidth = UIScreen.main.bounds.size.width - 60
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        
        while width > maxWidth {
            fontSize -= 1
            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
    }
}

