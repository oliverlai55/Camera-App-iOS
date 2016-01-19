//
//  FilterViewController.swift
//  Camera App
//
//  Created by Wei lun Lai on 1/18/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var filteredImage: UIImage?
    private var sourcePrefix : String?
    private var filters : [(filterName: String, path: String)] =
    [(filterName: String, path: String)]()
    private let filterManager : ImageFilterManager =
    ImageFilterManager()
    
    var sourceImage : UIImage? {
        didSet {
            self.sourcePrefix = NSUUID().UUIDString
            filterManager.createFiltersForImage(self.sourceImage!,
                filePrefix: self.sourcePrefix!) { (filters) -> Void in
                    self.filters = filters
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
            if segue.identifier == "FilterSelectedSegue" {
                if let indexPath = self.tableView.indexPathForSelectedRow
                {
                    let filter = self.filters[indexPath.item]
                    self.filteredImage = UIImage(contentsOfFile:
                        filter.path)
                }
            }
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            guard let cell =
                self.tableView.dequeueReusableCellWithIdentifier("filterReuseID",
                    forIndexPath: indexPath) as? FilterTableViewCell else {
                        return UITableViewCell()
            }
            let filter = self.filters[indexPath.item]
            cell.filterImageView.image = UIImage(contentsOfFile:
                filter.path)
            cell.filterNameLabel.text = filter.filterName
            return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
            return self.filters.count
    }
    
  
}
