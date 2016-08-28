//
//  GoogleMapsClient.swift
//  POI Locator
//
//  Created by Daniel Brand on 27.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import GooglePlaces
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
            
            guard let status = json[JsonResponseKeys.Status].string where status == JsonResponseValues.JsonOKStatus else {
                completionHandler(lat: nil, lon: nil, errorMessage: "Error getting the data")
                return
            }
            
            let lat = json[JsonResponseKeys.Results][0][JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lat].doubleValue
            let lon = json[JsonResponseKeys.Results][0][JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lng].doubleValue
            
            completionHandler(lat: lat, lon: lon, errorMessage: nil)
        }
        
        task.resume()
    }
    
    func getNearbyPlaces(position: CLLocationCoordinate2D, categories: [String], completionHandler: (places: [Place]!, errorMessage: String!) -> Void) {
        
        guard categories.count > 0 else {
            completionHandler(places: nil, errorMessage: "No Categories selected")
            return
        }
        
        let locationString = "\(position.latitude),\(position.longitude)"
        let categoriesString = categories.joinWithSeparator("|")
        
        let urlParameters: [String: AnyObject] = [
            URLParameterKeys.Location: locationString,
            URLParameterKeys.Radius: URLParametersValues.RadiusValue,
            URLParameterKeys.RankBy: URLParametersValues.ProminenceRank,
            URLParameterKeys.Categories: categoriesString,
            URLParameterKeys.Key: URLParametersValues.KeyValue
        ]
        
        let urlString = Constants.BaseUrlSecure + Methods.NearBySearch + Utility.escapedParameters(urlParameters)
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) in

            guard (error == nil) else {
                completionHandler(places: nil, errorMessage: error?.localizedDescription)
                return
            }
            
            let json = JSON(data: data!)
            
            guard let status = json[JsonResponseKeys.Status].string where status == JsonResponseValues.JsonOKStatus else {
                completionHandler(places: nil, errorMessage: "Error getting the data")
                return
            }
            
            var collectedPlaces = [Place]()
            for (key: _, subJson) in json[JsonResponseKeys.Results] {
                let lat = subJson[JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lat].doubleValue
                let lon = subJson[JsonResponseKeys.Geometry][JsonResponseKeys.Location][JsonResponseKeys.Lng].doubleValue
                let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                let id = subJson[JsonResponseKeys.Id].string
                let name = subJson[JsonResponseKeys.Name].string
                let placeId = subJson[JsonResponseKeys.PlaceId].string
                let vicinity = subJson[JsonResponseKeys.Vicinity].string
                let photoRef = subJson[JsonResponseKeys.Photos][0][JsonResponseKeys.PhotosRef].string
                let categorie = subJson[JsonResponseKeys.Categories][0].string
                let place = Place(position: position, category: categorie!, name: name!, id: id!, openNow: nil, vicinity: vicinity!, photoRef: photoRef, placeId: placeId!)
                
                collectedPlaces.append(place)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
            completionHandler(places: collectedPlaces, errorMessage: nil)
            }
        }
        
        task.resume()

    }
    
    func getPictureForPlace() {
        
    }
}