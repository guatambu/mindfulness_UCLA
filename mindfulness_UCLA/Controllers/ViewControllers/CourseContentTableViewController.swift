//
//  CourseContentTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Kelly Johnson on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class CourseContentTableViewController: UITableViewController {
    
    // MARK: Properties
    
    
    // MARK: ViewController Lifecycle Fucntions

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CourseContentModelController.shared.courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseContentCell", for: indexPath)
        
        cell.textLabel?.text = "week \(indexPath.row + 1)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toWeekCourseMaterials") as! WeekCourseMaterialsTableViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // pass any properties to next ViewController
        destViewController.week = indexPath.row
        destViewController.weekData = CourseContentModelController.shared.courses[indexPath.row]
        
    }
}
