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
    
    // title string
    var detailTitle: String?
    // array that holds the valid checked string tuples used to present the overview details
    var validOverviewOrderedContentStrings: /* [ [(String, String)] ]? */ [ (String, String) ]?
    // arrays to hold string tuples that are checked for valid content
    var validVideoStrings: [(String, String)]?
    var validVideosListStrings: [(String, String)]?
    var validReadingStrings: [(String, String)]?
    var validReadingsListStrings: [(String, String)]?
    var validPracticeStrings: [(String, String)]?
    var validPracticeSheetsStrings: [(String, String)]?
    var validSupplementalMaterialsStrings: [(String, String)]?
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the tableView for self sizing cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        if let detailTitle = detailTitle {
            
            title = detailTitle
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // here we will store the total number of rows
        var totalRows = 0
        
        // if valid overview content, then we loop through the array of arrays
        if let validOverviewOrderedContentStrings = validOverviewOrderedContentStrings {
            
            totalRows = validOverviewOrderedContentStrings.count
            
            // if valid videos content, then we loop through the array of arrays
            if let validVideosListStrings = validVideosListStrings {
                // set totalRows to individual tuple arrays count
                totalRows += validVideosListStrings.count
            }
        }
        // if valid videos content
        if let validVideosListStrings = validVideosListStrings {
            // set totalRows to individual tuple arrays count
            totalRows = validVideosListStrings.count
        }
        // if valid readings content
        if let validReadingsListStrings = validReadingsListStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validReadingsListStrings.count
        }
        // if valid practice strings content
        if let validPracticeStrings = validPracticeStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validPracticeStrings.count
        }
        // if valid practice sheets content
        if let validPracticeSheetsStrings = validPracticeSheetsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validPracticeSheetsStrings.count
        }
        // if valid supplemental materials content
        if let validSupplementalMaterialsStrings = validSupplementalMaterialsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validSupplementalMaterialsStrings.count
        }
        // in case the error case where ther are no valid rows to display in the tableView
        if totalRows == 0 {
            // handle the empty array error case
            print("ERROR: totalRows == 0 in CourseContentDetailsTableViewController.swift -> tableView(numberOfRowsInSection:) - line 84.")
        }
        return totalRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseContentDetailCell", for: indexPath) as? CourseContentDetailTableViewCell else {
            
            return UITableViewCell()
        }
        
        // if valid overview content, then we loop through the array of arrays
        if let validOverviewOrderedContentStrings = validOverviewOrderedContentStrings {
            
            cell.tupleStrings = validOverviewOrderedContentStrings[indexPath.row]
        }
        // if valid videos content
        else if let validVideosListStrings = validVideosListStrings {
            // set totalRows to individual tuple arrays count
            cell.tupleStrings = validVideosListStrings[indexPath.row]
        }
        // if valid readings content
        if let validReadingsListStrings = validReadingsListStrings {
            // set totalRows to individual tuple arrays count
            cell.tupleStrings = validReadingsListStrings[indexPath.row]
        }
        // if valid practice strings content
        if let validPracticeStrings = validPracticeStrings {
            // set totalRows to individual tuple arrays count
            cell.tupleStrings = validPracticeStrings[indexPath.row]
        }
        // if valid practice sheets content
        if let validPracticeSheetsStrings = validPracticeSheetsStrings {
            // set totalRows to individual tuple arrays count
            cell.tupleStrings = validPracticeSheetsStrings[indexPath.row]
        }
        // if valid supplemental materials content arrays
        if let validSupplementalMaterialsStrings = validSupplementalMaterialsStrings {
            // set totalRows to individual tuple arrays count
            cell.tupleStrings = validSupplementalMaterialsStrings[indexPath.row]
        }
        
        return cell
    }

}
