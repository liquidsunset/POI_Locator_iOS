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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if place.photoRef != nil{
            
        
        GoogleMapsClient.sharedInstance.getPictureForPlace(place.photoRef){
            (photo, error) in
            
            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Photo-Error", message: error)
                }
                return
            }
            
            print(photo)
        }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(place.name)
    }
}

