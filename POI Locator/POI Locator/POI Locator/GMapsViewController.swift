//
//  GMapsViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class GMapsViewController: UIViewController, SetMapPos, CategoryTableViewControllerDelegate {
   
    @IBOutlet weak var mapView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var selectedCategories = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
    }
    
    func setLatLon(latitude: Double, longitude: Double, title: String) {
        performUpdatesOnMain() {
            let pos = CLLocationCoordinate2DMake(latitude, longitude)
            let marker = GMSMarker(position: pos)
            marker.title = title
            
            let camera = GMSCameraPosition.cameraWithLatitude(latitude, longitude: longitude, zoom: 10)
            
        }
    }
    
    @IBAction func searchAddress(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    func categoryController(selectedCategories categories: [String]) {
        selectedCategories = categories
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CategorySegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! CategoryTableViewController
            controller.selectedCategories = selectedCategories
            controller.delegate = self
        }
    }
}

//SearchBar Stuff
extension GMapsViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
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
                self.searchResultController.loadResults(results)
            }
        }
        
    }
}

