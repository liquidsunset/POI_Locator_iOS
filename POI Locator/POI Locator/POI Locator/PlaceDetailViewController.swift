//
//  PlaceDetailViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {
    var place: GoogleMapsPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(place.name)
    }
}

