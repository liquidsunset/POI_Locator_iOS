//
//  GoogleMapsClient.swift
//  POI Locator
//
//  Created by Daniel Brand on 27.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import GooglePlacePicker
import SwiftyJSON

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
    
    func getLatLongForAddress(address: String, completionHandler: (lat: Double!, lon: Double!, errorMessage: String!) -> Void) {
        
        let urlParameters: [String:AnyObject] = [
            URLParameterKeys.Address: address
        ]
        let urlString = Constants.BaseUrlSecure + Methods.GeocodeSearch + Utility.escapedParameters(urlParameters)
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) in
            
            guard (error == nil) else {
                completionHandler(lat: nil, lon: nil, errorMessage: error?.localizedDescription)
                return
            }
            
            let json = JSON(data: data!)
            let lat = json[JsonResponseKeys.Results][0][JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lat].doubleValue
            let lon = json[JsonResponseKeys.Results][0][JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lng].doubleValue
            
            completionHandler(lat: lat, lon: lon, errorMessage: nil)
        }
        
        task.resume()
    }
    
    func getNearbyPlaces() {
        
    }
    
    func getPictureForPlace() {
        
    }
}