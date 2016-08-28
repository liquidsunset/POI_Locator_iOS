//
//  CategoryTableViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 26.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit

class CategoryTableViewController: UITableViewController {
    
    let categoryTypesDic = ["bakery":"Bakery", "museum": "Museum","bar":"Bar", "night_club": "Night Club", "cafe":"Cafe", "grocery_or_supermarket":"Supermarket", "library":"Library", "restaurant":"Restaurant", "church": "Church", "hospital": "Hospital", "police": "Police", "lodging": "Hotel"]
    
    var sortedKeys: [String] {
        return categoryTypesDic.keys.sort()
    }
    
    
    var selectedCategories: [String]!
    
    @IBAction func saveCategories(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedCategories, forKey: "savedCategories")
        defaults.synchronize()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTypesDic.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        let key = sortedKeys[indexPath.row]
        let type = categoryTypesDic[key]
        
        cell.textLabel?.text = type
        
        if let imageIcon = UIImage(named: key) {
          cell.imageView?.image = imageIcon
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        
        cell.accessoryType = (selectedCategories).contains(key) ? .Checkmark : .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let key = sortedKeys[indexPath.row]
        if (selectedCategories!).contains(key) {
            selectedCategories = selectedCategories.filter({$0 != key})
        } else {
            selectedCategories.append(key)
        }
        
        tableView.reloadData()
    }
}
