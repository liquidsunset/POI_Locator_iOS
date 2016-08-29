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
    var stack: CoreDataStack!

    override func viewWillAppear(animated: Bool) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        stack = delegate.stack
        fetchBookmarks()
        tableView.reloadData()
    }

    func fetchBookmarks() {

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
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkCell")! as UITableViewCell
        cell.textLabel?.text = bookmarks[indexPath.row].name
        cell.detailTextLabel?.text = bookmarks[indexPath.row].address

        if let imageIcon = UIImage(named: bookmarks[indexPath.row].category!) {
            cell.imageView?.image = imageIcon
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            stack.context.deleteObject(bookmarks[indexPath.row])
            stack.save()
            fetchBookmarks()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
        }
    }
}