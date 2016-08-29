//
//  PlaceMarker.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import GoogleMaps

class GoogleMapsPlaceMarker: GMSMarker {
    let place: GoogleMapsPlace

    init(place: GoogleMapsPlace) {
        self.place = place
        super.init()
        position = place.position
        icon = UIImage(named: place.category)
        appearAnimation = kGMSMarkerAnimationPop
    }

    func getPlace() -> GoogleMapsPlace {
        return place
    }
}