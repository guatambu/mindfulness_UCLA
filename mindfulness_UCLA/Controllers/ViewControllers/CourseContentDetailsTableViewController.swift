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
    var validpPacticeSheetsStrings: [(String, String)]?
    var validSupplementalMaterialsStrings: [(String, String)]?
    var validGuidedMeditationStrings: [(String, String)]?
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
