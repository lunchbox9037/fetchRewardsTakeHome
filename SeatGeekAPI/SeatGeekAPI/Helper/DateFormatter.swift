//
//  DateFormatter.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import Foundation

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}

extension Date {
    enum DateFormatType: String {
        case full = "EEEE, MMM d, yyyy HH:mm a"
    }
    
    func dateToString(format: DateFormatType) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
