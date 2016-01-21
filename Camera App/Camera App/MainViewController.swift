//
//  MainViewController.swift
//  Camera App
//
//  Created by Wei lun Lai on 12/2/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, FBSDKSharingDelegate {
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        print(results)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer NSError")
        print(error.description)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    
    private var currentZoom : CGFloat = 1.0
    
    func zoomImage(){
        if self.currentZoom == 1.0 {
            self.currentZoom = 2.0
        }
        else {
            self.currentZoom = 1.0 }
        
        UIView.animateWithDuration(0.5) {[unowned self] in 
        self.scrollView.minimumZoomScale = self.currentZoom
        self.scrollView.maximumZoomScale = self.currentZoom
        self.scrollView.zoomScale = self.currentZoom
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? { return self.displayImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageStore = [UIImage]()

        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: "zoomImage")
        gesture.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(gesture)
        self.scrollView.delegate = self
        previewCollectionView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
            if segue.identifier == "FilterSegue" {
                if let vc : FilterViewController =
                    segue.destinationViewController as? FilterViewController {
                        vc.sourceImage = self.displayImageView.image
                }
            }
    }

    @IBAction func actionButtonTouched(sender: AnyObject) {
        if let image = self.displayImageView.image {
            let sharePhoto = FBSDKSharePhoto(image: image, userGenerated: true)
            let content = FBSDKSharePhotoContent()
            content.photos = [sharePhoto]
            FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
        }
       
    }
    
    @IBAction func cameraButtonTouched(sender: UIBarButtonItem){
       self.displayImagePicker(.Camera)
    }
    
    @IBAction func libraryButtonTouched(sender: UIBarButtonItem) {
        self.displayImagePicker(.PhotoLibrary)
    }
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var displayImageView: UIImageView!
    
    //Unwind Segue
    @IBAction func didSelectFilter(segue: UIStoryboardSegue) {
        if segue.identifier == "FilterSelectedSegue" {
            if let source = segue.sourceViewController as?
                FilterViewController,
                let image = source.filteredImage {
                    self.displayImageView.image = image
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage,
        editingInfo: [String : AnyObject]?) {
            self.imageStore.insert(image, atIndex: 0)
            self.previewCollectionView.reloadData()
            previewCollectionView.alpha = 1.0
            self.displayImageView.image = image
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayImagePicker(sType:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sType
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet var previewCollectionView: UICollectionView!
    
    private var imageStore : [UIImage]!
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let image = self.imageStore![indexPath.item]
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PreviewCellReuseID", forIndexPath: indexPath) as? PreviewCollectionViewCell {
            
            cell.previewImageView.image = image
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageStore.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            let image = self.imageStore[indexPath.item]
            self.displayImageView.image = image
    }
}
