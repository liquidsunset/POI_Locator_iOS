//
//  GoogleMapsClient.swift
//  POI Locator
//
//  Created by Daniel Brand on 27.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import GooglePlacePicker

class GoogleMapsClient {
    
    static let sharedInstance = GoogleMapsClient()
    
    func getAutocompleteResults(searchText: String, completionHandler: (result: [String]!, errorMessage: String!) -> Void) {
        let gmsPlaceClient = GMSPlacesClient()
        
        gmsPlaceClient.autocompleteQuery(searchText, bounds: nil, filter: nil) {
            (results, error: NSError?) -> Void in
            
            guard (error == nil) else {
                completionHandler(result: nil, errorMessage: (error?.localizedDescription)!)
                return
            }
            
            var resultsArray = [String]()
            
            for result in results! {
                    resultsArray.append(result.attributedFullText.string)
                
            }
            
            completionHandler(result: resultsArray, errorMessage: nil)
        }

    }
}