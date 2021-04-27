//
//  Favorite+Convenience.swift
//  SeatGeekAPI
//
//  Created by stanley phillips on 4/27/21.
//

import CoreData

extension Favorite {
    @discardableResult convenience init(name: String, date: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.date = date
    }
}
