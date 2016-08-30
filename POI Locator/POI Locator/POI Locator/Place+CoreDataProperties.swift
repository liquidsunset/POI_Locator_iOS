//
//  Place+CoreDataProperties.swift
//  POI Locator
//
//  Created by Daniel Brand on 30.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var address: String?
    @NSManaged var category: String?
    @NSManaged var image: NSData?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var comment: String?
    @NSManaged var rating: NSNumber?

}
