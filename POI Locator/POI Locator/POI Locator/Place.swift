//
//  Place.swift
//  POI Locator
//
//  Created by Daniel Brand on 29.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Place: NSManagedObject {


    convenience init(latitude: Double, longitude: Double, address: String, name: String, category: String, image: UIImage, context: NSManagedObjectContext) {
        if let createEntity = NSEntityDescription.entityForName("Place", inManagedObjectContext: context) {
            self.init(entity: createEntity, insertIntoManagedObjectContext: context)
            self.latitude = latitude
            self.longitude = longitude
            self.address = address
            self.name = name
            self.category = category
            self.image = UIImagePNGRepresentation(image)
        } else {
            fatalError("Unable to find Entity Name!")
        }
    }


}
