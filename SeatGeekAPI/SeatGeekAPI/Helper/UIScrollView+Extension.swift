//
//  UIScrollView+Extension.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/30/21.
//

import UIKit

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
