//
//  Place.swift
//  POI Locator
//
//  Created by Daniel Brand on 29.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import CoreData

class Place: NSManagedObject {
    
    convenience init(latitude: Double, longitude: Double, address: String,name: String, context: NSManagedObjectContext){
        if let createEntity = NSEntityDescription.entityForName("Place", inManagedObjectContext: context){
            self.init(entity: createEntity, insertIntoManagedObjectContext: context)
            self.latitude = latitude
            self.longitude = longitude
        } else {
            fatalError("Unable to find Entity Name!")
        }
    }
    
}