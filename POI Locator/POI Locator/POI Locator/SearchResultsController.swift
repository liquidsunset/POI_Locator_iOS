//
//  SearchResultsController.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit

protocol SetMapPos {
    func setLatLon(latitude: Double, longitude: Double, title: String)
}

class SearchResultsController: UITableViewController {

    var results: [String]!
    var delegate: SetMapPos!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        results = Array()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "resultIdentifier")
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        GoogleMapsClient.sharedInstance.getLatLongForAddress(results[indexPath.row]) {
            (lat, lon, error) in

            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Address-Error", message: error)
                }
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            self.delegate.setLatLon(lat, longitude: lon, title: self.results[indexPath.row])
        }

    }

    func loadResults(searchResult: [String]) {
        results = searchResult
        tableView.reloadData()
    }


}