//
//  FlickrClient.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CoreLocation

class FlickrClient {

    static let sharedInstance = FlickrClient()

    func getPictures(pageNumber: Int?, position: CLLocationCoordinate2D, completionHandler: (data:AnyObject?, errorMessage:String?) -> Void) {


        let urlString = self.createFlickrUrlString(pageNumber, lat: position.latitude, lon: position.longitude)

        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            data, response, error in

            guard (error == nil) else {
                return completionHandler(data: nil, errorMessage: error?.description)
            }

            guard let data = data else {
                completionHandler(data: nil, errorMessage: "No data received")
                return
            }

            Utility.parseJSONWithCompletionHandler(data) {
                (parsedJsonResult, error) in
                guard (error == nil) else {
                    completionHandler(data: nil, errorMessage: "Failed to parse Data")
                    return
                }

                guard let parsedJsonResult = parsedJsonResult else {
                    completionHandler(data: nil, errorMessage: "Failed to parse Data")
                    return
                }

                guard let status = parsedJsonResult[JsonResponseKeys.Status] as? String where status == JsonResponseValues.JsonOKStatus else {
                    completionHandler(data: nil, errorMessage: "Failure in JSON-Response")
                    return
                }

                guard let photosDic = parsedJsonResult[JsonResponseKeys.Photos] as? [String:AnyObject] else {
                    completionHandler(data: nil, errorMessage: "Error getting photo-dic")
                    return
                }

                if (pageNumber == nil) {
                    guard let pages = photosDic[JsonResponseKeys.Pages] as? Int else {
                        completionHandler(data: nil, errorMessage: "No Flickr Photo-Page found")
                        return
                    }
                    let pageLimit = min(pages, 40)
                    let random = Int(arc4random_uniform(UInt32(pageLimit))) + 1
                    self.getPictures(random, position: position, completionHandler: completionHandler)

                } else {

                    guard let photoArray = photosDic[JsonResponseKeys.Photo] as? [[String:AnyObject]] else {
                        completionHandler(data: nil, errorMessage: "Error creating photo-array")
                        return
                    }

                    guard (photoArray.count != 0) else {
                        completionHandler(data: nil, errorMessage: "No photos found")
                        return
                    }

                    completionHandler(data: photoArray, errorMessage: nil)
                }
            }

        }
        task.resume()

    }

    private func createFlickrUrlString(pageNumber: Int?, lat: Double, lon: Double) -> String {
        var urlParameters: [String:AnyObject] = [
                URLParameterKeys.APIKey: Constants.FlickrAPIKey,
                URLParameterKeys.SafeSearch: URLParameterValues.UseSafeSearch,
                URLParameterKeys.Extras: URLParameterValues.MediumURL,
                URLParameterKeys.Method: Methods.FlickrPhotoSearch,
                URLParameterKeys.PerPage: URLParameterValues.PicsPerPage,
                URLParameterKeys.Format: URLParameterValues.JsonFormat,
                URLParameterKeys.Lat: lat,
                URLParameterKeys.Lon: lon,
                URLParameterKeys.Radius: URLParameterValues.Radius,
                URLParameterKeys.NoJsonCallback: URLParameterValues.NOJsonCallback
        ]
        if (pageNumber == nil) {
        } else {
            urlParameters[URLParameterKeys.Page] = pageNumber
        }
        return Constants.BaseUrlSecure + Utility.escapedParameters(urlParameters)

    }

}
