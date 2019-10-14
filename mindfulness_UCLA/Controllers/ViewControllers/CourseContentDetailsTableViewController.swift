//
//  CourseContentDetailsTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/12/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class CourseContentDetailsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    // array that holds the valid checked string tuples used to present the overview details
    var validOverviewOrderedContentStrings: [ [(String, String)] ]?
    // arrays to hold string tuples that are checked for valid content
    var validVideoStrings: [(String, String)]?
    var validVideosListStrings: [(String, String)]?
    var validReadingStrings: [(String, String)]?
    var validReadingsListStrings: [(String, String)]?
    var validPracticeStrings: [(String, String)]?
    var validPacticeSheetsStrings: [(String, String)]?
    var validSupplementalMaterialsStrings: [(String, String)]?
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // here we will store the total number of rows
        var totalRows = 0
        
        // if valid overview content, then we loop through the array of arrays
        if let validOverviewOrderedContentStrings = validOverviewOrderedContentStrings {
            // loop through the array of arrays
            for tupleArray in validOverviewOrderedContentStrings {
                // ensuring there is no empty array here
                if !tupleArray.isEmpty {
                    // increment totalRows with each individual tuple arrays count
                    totalRows += tupleArray.count
                } else {
                    // handle the empty array error case
                    print("ERROR: empty tuple array in validOverviewOrderedContentStrings array in CourseContentDetailsTableViewController.swift -> tableView(numberOfRowsInSection:) - line 54.")
                }
            }
        }
        // if valid videos content, then we loop through the array of arrays
        if let validVideosListStrings = validVideosListStrings {
            // set totalRows to individual tuple arrays count
            totalRows = validVideosListStrings.count
        }
        // if valid readings content, then we loop through the array of arrays
        if let validReadingsListStrings = validReadingsListStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validReadingsListStrings.count
        }
        // if valid praactice sheets content, then we loop through the array of arrays
        if let validPacticeSheetsStrings = validPacticeSheetsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validPacticeSheetsStrings.count
        }
        // if valid supplemental materials content, then we loop through the array of arrays
        if let validSupplementalMaterialsStrings = validSupplementalMaterialsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validSupplementalMaterialsStrings.count
        }
        // in case the error case where ther are no valid rows to display in the tableView
        if totalRows == 0 {
            // handle the empty array error case
            print("ERROR: totalRows == 0 in CourseContentDetailsTableViewController.swift -> tableView(numberOfRowsInSection:) - line 83.")
        }
        return totalRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

}
