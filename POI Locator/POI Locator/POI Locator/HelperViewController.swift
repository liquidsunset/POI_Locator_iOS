//
//  HelperViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 27.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(ok)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func performUpdatesOnMain(updates: () -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            updates()
        }
    }
    
    struct Constants {
        static let categoryTypesDic = ["bakery":"Bakery", "museum": "Museum","bar":"Bar", "night_club": "Night Club", "cafe":"Cafe", "grocery_or_supermarket":"Supermarket", "library":"Library", "restaurant":"Restaurant", "church": "Church", "hospital": "Hospital", "police": "Police"]
    }
}