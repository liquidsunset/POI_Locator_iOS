//
//  Place.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class GoogleMapsPlace {
    let position: CLLocationCoordinate2D
    let category: String
    let name: String
    let id: String
    var openNow: Bool?
    let vicinity: String
    var photoRef: String?
    let placeId: String
    var photo: UIImage!

    init(position: CLLocationCoordinate2D, category: String, name: String, id: String, openNow: Bool?, vicinity: String, photoRef: String?, placeId: String) {
        self.position = position
        self.category = category
        self.name = name
        self.id = id
        self.openNow = openNow
        self.vicinity = vicinity
        self.photoRef = photoRef
        self.placeId = placeId
    }
}