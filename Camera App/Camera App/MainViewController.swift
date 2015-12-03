//
//  MainViewController.swift
//  Camera App
//
//  Created by Wei lun Lai on 12/2/15.
//  Copyright © 2015 DigitalCrafts. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cameraButtonTouched(sender: UIBarButtonItem){
       self.displayImagePicker(.Camera)
    }
    @IBAction func libraryButtonTouched(sender: UIBarButtonItem) {
        self.displayImagePicker(.PhotoLibrary)
    }
    
    @IBOutlet var displayImageView: UIImageView!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage,
        editingInfo: [String : AnyObject]?) {
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
    
    
}
