//
//  PlaceDetailViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PlaceDetailViewController: UIViewController {

    var place: GoogleMapsPlace!
    var photos: [UIImage] = [UIImage]()
    var stack: CoreDataStack!

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        addressLabel.lineBreakMode = .ByWordWrapping
        addressLabel.numberOfLines = 2
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        stack = delegate.stack

        if place.photoRef != nil {

            GoogleMapsClient.sharedInstance.getPictureForPlace(place.photoRef) {
                (photo, error) in

                guard (error == nil) else {
                    self.performUpdatesOnMain() {
                        self.showAlertMessage("Photo-Error", message: error)
                    }
                    return
                }

                self.performUpdatesOnMain() {
                    self.place.photo = photo
                    self.placeImageView.image = photo
                }

            }

        } else {
            place.photo = UIImage(named: "placeholder")
            placeImageView.image = place.photo
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = place.name
        addressLabel.text = place.vicinity
        categoryLabel.text = CategoryTableViewController().getCategoryForKey(place.category)
        collectionView.delegate = self
        collectionView.dataSource = self
        getImages()
    }

    @IBAction func refreshImages(sender: AnyObject) {
        getImages()
        collectionView.reloadData()
    }

    @IBAction func saveBookmark(sender: AnyObject) {
        _ = Place(latitude: place.position.latitude, longitude: place.position.longitude, address: place.vicinity, name: place.name, category: place.category, context: stack.context)
        stack.save()
        navigationController!.popViewControllerAnimated(true)
    }

    func getImages() {
        photos.removeAll()
        FlickrClient.sharedInstance.getPictures(nil, position: place.position) {
            (data, error) in

            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Photo-Error", message: error!)
                }
                return
            }

            self.performUpdatesOnMain() {

                let imagesUrls = data as! [[String:AnyObject]]
                for imageUrl in imagesUrls {
                    let imageDic = imageUrl as [String:AnyObject]
                    guard let imageURLString = imageDic[FlickrClient.JsonResponseKeys.MediumURL] as? String else {
                        self.showAlertMessage("Image-Erro", message: "No valid URL found")
                        return
                    }
                    let imageURL = NSURL(string: imageURLString)
                    let imageData = NSData(contentsOfURL: imageURL!)

                    self.photos.append(UIImage(data: imageData!)!)
                }
            }
            self.performUpdatesOnMain() {
                self.collectionView.reloadData()
            }
        }

    }
}

extension PlaceDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrCell", forIndexPath: indexPath) as! FlickrCell
        cell.imageView.image = photos[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
}
