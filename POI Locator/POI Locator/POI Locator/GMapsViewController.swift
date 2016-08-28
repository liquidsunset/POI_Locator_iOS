//
//  GMapsViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps

class GMapsViewController: UIViewController, SetMapPos {
   
    @IBOutlet weak var mapView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var selectedCategories: [String]!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        getSavedCategories()
    }
    
    func setLatLon(latitude: Double, longitude: Double, title: String) {
        performUpdatesOnMain() {
            let pos = CLLocationCoordinate2DMake(latitude, longitude)
            let marker = GMSMarker(position: pos)
            marker.title = title
            marker.appearAnimation = kGMSMarkerAnimationPop
            
            let camera = GMSCameraPosition.cameraWithLatitude(latitude, longitude: longitude, zoom: 15)
            self.mapView.camera = camera
            marker.map = self.mapView
            self.mapView.selectedMarker = marker
        }
    }
    
    @IBAction func searchAddress(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    @IBAction func search(sender: AnyObject) {
        getPlaces()
    }
    
    func getSavedCategories() {
        let defaults = NSUserDefaults.standardUserDefaults()
        selectedCategories = defaults.objectForKey("savedCategories") as? [String] ?? [String]()
    }
    
    func getPlaces() {
        mapView.clear()
        GoogleMapsClient.sharedInstance.getNearbyPlaces(mapView.camera.target, categories: selectedCategories){
         (places, error) in
            
            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Address-Error", message: error)
                }
                return
            }

            for place in places{
                let marker = PlaceMarker(place: place)
                marker.map = self.mapView
                }}
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CategorySegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! CategoryTableViewController
            controller.selectedCategories = selectedCategories
        }
    }
}

//SearchBar Stuff
extension GMapsViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            resultsArray.removeAll()
            searchResultController.loadResults(resultsArray)
            return
        }
        
        GoogleMapsClient.sharedInstance.getAutocompleteResults(searchText) {
            (results, error) in
            
            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Address-Error", message: error)
                }
                return
            }
            
            guard results.count != 0 else {
                return
            }
            
            self.performUpdatesOnMain() {
                self.resultsArray.removeAll()
                self.resultsArray = results
                self.searchResultController.loadResults(results)
            }
        }
        
    }
}



