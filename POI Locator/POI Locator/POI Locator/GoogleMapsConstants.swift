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
        static let NearBySearch = "place/nearbysearch/json"
    }

    struct URLParameterKeys {
        static let Address = "address"
        static let Radius = "radius"
        static let RankBy = "rankby"
        static let Location = "location"
        static let Categories = "types"
        static let Key = "key"
    }

    struct URLParametersValues {
        static let RadiusValue = 1500
        static let ProminenceRank = "prominence"
        static let KeyValue = "AIzaSyCG0V0sKWvU4jrXLgkX74mshykyJjloTHQ"
    }

    struct JsonResponseKeys {
        static let Status = "status"
        static let Geometry = "geometry"
        static let Results = "results"
        static let Location = "location"
        static let Lat = "lat"
        static let Lng = "lng"
        static let Id = "id"
        static let Name = "name"
        static let PlaceId = "place_id"
        static let Vicinity = "vicinity"
        static let Photos = "photos"
        static let PhotosRef = "photos_reference"
        static let Categories = "types"
    }

    struct JsonResponseValues {
        static let JsonOKStatus = "OK"
    }

}

