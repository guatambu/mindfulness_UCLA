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
    
    let weeks: [Int] = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
    
    // MARK: ViewController Lifecycle Fucntions

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseContentCell", for: indexPath)
        
        cell.textLabel?.text = "week \(weeks[indexPath.row])"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
