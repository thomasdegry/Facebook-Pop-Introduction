//
//  LocationsTableViewController.swift
//  Animation
//
//  Created by LOANER on 3/14/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController, LocationDelegate {
    var locations:NSArray?
    var activeCell:LocationTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get rid of the tableviewline
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.showsVerticalScrollIndicator = false
        
        // Set a backgroundColor
        self.view.backgroundColor = UIColor(red: 0.184, green: 0.216, blue: 0.243, alpha: 1)
        
        // Load the plist
        if let path = NSBundle.mainBundle().pathForResource("Locations", ofType: "plist") {
            self.locations = NSArray(contentsOfFile: path)
        }
        
        self.navigationItem.title = "Locations"
    }
    
    func showLocationFor(cell: LocationTableViewCell) {
        // Instantiate view controller
        let storyoard = UIStoryboard(name: "Main", bundle: nil)
        let locationVC = storyboard?.instantiateViewControllerWithIdentifier("locationVC") as? LocationViewController
        
        // Send the location along
        locationVC?.location = cell.location
        
        // Push the new controller
        self.navigationController?.pushViewController(locationVC!, animated: true)
    }
    
    func didSetNewDetailCell(cell: LocationTableViewCell) {
        if let ac = self.activeCell {
            ac.hideDetail()
        }
        
        self.activeCell = cell
    }
    
    func didUnsetDetailCell(cell: LocationTableViewCell) {
        if (self.activeCell == cell) {
            self.activeCell = nil
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! LocationTableViewCell
        cell.delegate = self

        if let actualArray = self.locations {
            if let locationDict = actualArray[indexPath.row] as? NSDictionary {
                let location = self.locationForDictionary(locationDict, indexRow: indexPath.row)
                cell.location = location
            }
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 325
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? LocationTableViewCell
    }
    
    func locationForDictionary(locationDict:NSDictionary, indexRow:Int) -> Location {
        var location = Location()
        if let state = locationDict.objectForKey("state") as? String {
            location.state = state
        }
        
        if let place = locationDict.objectForKey("place") as? String {
            location.place = place
        }
        
        if let lat = locationDict.objectForKey("lat") as? String {
            location.lat = lat
        }
        
        if let long = locationDict.objectForKey("long") as? String {
            location.long = long
        }
        
        if let image = locationDict.objectForKey("image") as? String {
            location.image = image
        }
        
        location.delay = 0.3 + (Float(indexRow) * 0.1)
        
        return location
    }

}
