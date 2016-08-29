//
//  BookmarkTableViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 29.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookmarkTableViewController: UITableViewController {
    
    var bookmarks: [Place] = [Place]()
    
    override func viewWillAppear(animated: Bool) {
        fetchBookmarks()
    }
    
    func fetchBookmarks(){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = delegate.stack
        do {
            let fr = NSFetchRequest(entityName: "Place")
            
            bookmarks = try stack.context.executeFetchRequest(fr) as! [Place]
        } catch {
            print("Error")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkCell", forIndexPath: indexPath)
        cell.textLabel?.text = bookmarks[indexPath.row].name
        cell.detailTextLabel?.text = bookmarks[indexPath.row].address
        
        if let imageIcon = UIImage(named: bookmarks[indexPath.row].category!) {
            cell.imageView?.image = imageIcon
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        return cell
    }
}