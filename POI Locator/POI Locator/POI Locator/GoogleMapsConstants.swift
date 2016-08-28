//
//  GoogleMapsConstants.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation

extension GoogleMapsClient {
    
    struct Constants {
        static let BaseUrlSecure = "https://maps.googleapis.com/maps/api/"
    }
    
    struct Methods {
        static let GeocodeSearch = "geocode/json"
        static let NearBySearch = "nearbysearch/json"
    }
    
    struct URLParameterKeys {
        static let Address = "address"
        static let Radius = "radius"
        static let RankBy = "rankby"
    }
    
    struct URLParametersValues {
        static let RadiusValue = 1
        static let ProminenceRank = "prominence"
    }
    
    struct JsonResponseKeys {
        static let Status = "status"
        static let Geometry = "geometry"
        static let Results = "results"
        static let Location = "location"
        static let Lat = "lat"
        static let Lng = "lng"
    }
    
    struct JsonResponseValues {
        static let JsonOKStatus = "OK"
    }
}

