//
//  PlaceDetailViewController.swift
//  POI Locator
//
//  Created by Daniel Brand on 28.08.16.
//  Copyright © 2016 Daniel Brand. All rights reserved.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {
    
    var place: GoogleMapsPlace!
    var photos: [[String: AnyObject]]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if place.photoRef != nil{
            
        
        GoogleMapsClient.sharedInstance.getPictureForPlace(place.photoRef){
            (photo, error) in
            
            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Photo-Error", message: error)
                }
                return
            }
        }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getImages()
           }
    
    func getImages() {
        FlickrClient.sharedInstance.getPictures(nil, position: place.position) {
            (data, error) in
            
            guard (error == nil) else {
                self.performUpdatesOnMain() {
                    self.showAlertMessage("Photo-Error", message: error!)
                }
                return
            }
            
            self.performUpdatesOnMain() {
             self.photos = data as? [[String:AnyObject]]
            self.collectionView.reloadData()
            }
            
        }

    }
}

extension PlaceDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let photoEntry = photos![indexPath.row] as [String: AnyObject]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrCell", forIndexPath: indexPath) as! FlickrCell
        
        guard let imageURLString = photoEntry[FlickrClient.JsonResponseKeys.MediumURL] as? String else {
            showAlertMessage("Foto-Error", message: "Could not load Foto")
            return cell
        }
        
        let imageURL = NSURL(string: imageURLString)
        
        if let photo = NSData(contentsOfURL: imageURL!) {
            cell.imageView.image = UIImage(data: photo)
        }
        
        return cell
    }
}
