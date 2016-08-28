//
//  PlaceMarker.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: Place
    
    init(place: Place) {
        self.place = place
        super.init()
        position = place.position
        appearAnimation = kGMSMarkerAnimationPop
        icon = UIImage(named: place.category)
    }
}