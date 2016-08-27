//
//  GMapsViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class GMapsViewController: UIViewController, UISearchBarDelegate, SetMapPos {
   
    func setLatLon(latitude: Double, longitude: Double, title: String) {
        performUpdatesOnMain() {
            let pos = CLLocationCoordinate2DMake(latitude, longitude)
            let marker = GMSMarker(position: pos)
            marker.title = title
            
            let camera = GMSCameraPosition.cameraWithLatitude(latitude, longitude: longitude, zoom: 10)
            
        }
    }
}