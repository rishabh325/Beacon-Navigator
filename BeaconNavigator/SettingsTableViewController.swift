//
//  SettingsTableViewController.swift
//  BeaconNavigator
//
//  Created by Alex Deutsch on 15.07.15.
//  Copyright (c) 2015 Alexander Deutsch. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        // Configure the cell...
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Trilateration"
            case 1:
                cell.textLabel?.text = "Trilateration 2"
            case 2:
                cell.textLabel?.text = "Least Squares"
            default:
                break
            }
            cell.accessoryType = NSUserDefaults.standardUserDefaults().integerForKey("LocationMethod") == indexPath.row ? .Checkmark : .None
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Beacon Accuracy"
            case 1:
                cell.textLabel?.text = "Accuracy calculated by RSSI"
            default:
                break
            }
            cell.accessoryType = NSUserDefaults.standardUserDefaults().integerForKey("DistanceType") == indexPath.row ? .Checkmark : .None
        default:
            break
        }

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "LocationMethod")
        case 1:
            NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "DistanceType")
        default:
            break
        }
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Location Method"
        case 1:
            return "Distance Type"
        default:
            break
        }
        return nil
    }
}
