//
//  WeekCourseMaterialsTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class WeekCourseMaterialsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var week: Int?
    var weekData: WeekCourseContent?
    
    let weekHeadings: [ WeekHeadings ] = [ WeekHeadings.overview,
                                           WeekHeadings.videos,
                                           WeekHeadings.readings,
                                           WeekHeadings.dailyPractice,
                                           WeekHeadings.practiceSheets,
                                           WeekHeadings.supplementalMaterials
                                        ]
    
    // arrays to hold string tuples that are checked for valid content
    var validIntroStrings: [(String, String)] = []
    var validVideoStrings: [(String, String)] = []
    var validReadingStrings: [(String, String)] = []
    var validPracticeStrings: [(String, String)] = []
    var validMiscStrings: [(String, String)] = []
    var validVideosListStrings: [(String, String)] = []
    var validReadingsListStrings: [(String, String)] = []
    var validPracticeSheetsStrings: [(String, String)] = []
    var validSupplementalMaterialsStrings: [(String, String)] = []
    var validGuidedMeditationStrings: [(String, String)] = []
    
    // array that holds the valid checked string tuples used to present the overview details
    var validOverviewOrderedContentStrings: /* [ [(String, String)] ]*/ [ (String, String) ]  = []
    

    // MARK: ViewController Lifecycle Funcitons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let week = week else {
            
            print("ERROR: nil value foudn for week in WeekCourseMaterialsTableViewController.swift -> viewDidLoad() - line 34.")
            
            return
        }
        // set page title in nav bar
        title = "week \(week + 1)"
        // set up the Data for display and use
        setupWeekData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weekHeadings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCourseMaterialCell", for: indexPath)

        // Configure the cell...
        if indexPath.row == 0 {
            
            if let week = week {
                
                cell.textLabel?.text = "week \(week + 1) \(weekHeadings[indexPath.row].rawValue)"
            }
        } else {
            
            cell.textLabel?.text = weekHeadings[indexPath.row].rawValue
            
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // programmatically performing the segue
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toCourseContentDetails") as! CourseContentDetailsTableViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
        // pass any properties to next ViewController
        switch indexPath.row {
            
        case 0:
            destViewController.validOverviewOrderedContentStrings = validOverviewOrderedContentStrings
            destViewController.detailTitle = "week \((week ?? 0) + 1) \(weekHeadings[indexPath.row].rawValue)"
            
        case 1 :
            destViewController.validVideoStrings = validVideoStrings
            destViewController.validVideosListStrings = validVideosListStrings
            destViewController.detailTitle = weekHeadings[indexPath.row].rawValue
            
        case 2:
            destViewController.validReadingStrings = validReadingStrings
            destViewController.validReadingsListStrings = validReadingsListStrings
            destViewController.detailTitle = weekHeadings[indexPath.row].rawValue
            
        case 3:
            destViewController.validPracticeStrings = validPracticeStrings
            destViewController.detailTitle = weekHeadings[indexPath.row].rawValue
            
        case 4:
            destViewController.validPracticeSheetsStrings = validPracticeSheetsStrings
            destViewController.detailTitle = weekHeadings[indexPath.row].rawValue
            
        case 5:
            destViewController.validSupplementalMaterialsStrings = validSupplementalMaterialsStrings
            destViewController.detailTitle = weekHeadings[indexPath.row].rawValue
            
        default:
            return
        }
    }
}


// NOTE: - please consider whether it is simpler to just append the tuples to the validOverviewOrderedContentStrings array rather than the array of tuples, it may be that the array of arrays makes later indexPath values unnecessarily complex

extension WeekCourseMaterialsTableViewController {
    // function to be called in viewDidLoad() to prepare the data for implementation
    func setupWeekData() {
        // unwrap the week's data object
        guard let weekData = weekData else { return }
        // access the various week's non optional (String, String) properties
        let lessonTitle = weekData.lessonTitle
        let lessonSubtitle = weekData.lessonSubTitle ?? ""
        let intro1 = weekData.introTextParagraph1
        let videos1 = weekData.videosTextParagraph1
        let readings1 = weekData.readingsTextParagraph1
        let practice1 = weekData.dailyPracticesTextParagraph1
        let misc1 = weekData.miscellaneousTextParagraph1
        // access the various week's non optional [(String, String)] array properties
        let videosList = weekData.weekVideoURLList
        let readingsList = weekData.weekReadingURLList
        let practiceSheets = weekData.practiceSheetsURLList
        let supplementalMaterials = weekData.supplementalMaterialsURLList
        
        // unwrap optional properties
        let intro2 = weekData.introTextParagraph2 ?? ("","")
        let intro3 = weekData.introTextParagraph3 ?? ("","")
        let videos2 = weekData.videosTextParagraph2 ?? ("","")
        let videos3 = weekData.videosTextParagraph3 ?? ("","")
        let readings2 = weekData.readingsTextParagraph2 ?? ("","")
        let readings3 = weekData.readingsTextParagraph3 ?? ("","")
        let practice2 = weekData.dailyPracticesTextParagraph2 ?? ("","")
        let practice3 = weekData.dailyPracticesTextParagraph3 ?? ("","")
        let misc2 = weekData.miscellaneousTextParagraph2 ?? ("","")
        let misc3 = weekData.miscellaneousTextParagraph3 ?? ("","")
        
        // create arrays of Tuples for each of the week's overview instructions
        let introStrings: [(String, String)] = [intro1, intro2, intro3]
        let videoStrings: [(String, String)] = [videos1, videos2, videos3]
        let readingStrings: [(String, String)] = [readings1, readings2, readings3]
        let practiceStrings: [(String, String)] = [practice1, practice2, practice3]
        let miscStrings: [(String, String)] = [misc1, misc2, misc3]
        
        // reset tthe valid overvoew array
        validOverviewOrderedContentStrings = []
        
        validOverviewOrderedContentStrings.append((lessonTitle, ""))
        validOverviewOrderedContentStrings.append(("", lessonSubtitle))
        
        // check for valid (i.e. contains more than an empty string) intro strings
        for string in introStrings {
            
            if string.1 != "" {
                // append to the validIntroStrings array
                validIntroStrings.append(string)
                // appemd to the validOverviewOrderedContentStrings array as well
                validOverviewOrderedContentStrings.append(string)
            }
        }
        // check for valid (i.e. contains more than an empty string) video strings
        for string in videoStrings {
            
            if string.1 != "" {
                // append to the validVideoStrings array
                validVideoStrings.append(string)
                // appemd to the validOverviewOrderedContentStrings array as well
                validOverviewOrderedContentStrings.append(string)
            }
        }
        // check for valid (i.e. contains more than an empty string) reading strings
        for string in readingStrings {
            
            if string.1 != "" {
                // append to the validReadingsStrings array
                validReadingStrings.append(string)
                // appemd to the validOverviewOrderedContentStrings array as well
                validOverviewOrderedContentStrings.append(string)
            }
        }
        // check for valid (i.e. contains more than an empty string) practice strings
        for string in practiceStrings {
            
            if string.1 != "" {
                // append to the validPracticeStrings array
                validPracticeStrings.append(string)
                // appemd to the validOverviewOrderedContentStrings array as well
                validOverviewOrderedContentStrings.append(string)
            }
        }
        // check for valid (i.e. contains more than an empty string) misc strings
        for string in miscStrings {
            
            if string.1 != "" {
                // append to the validMiscStrings array
                validMiscStrings.append(string)
                // appemd to the validOverviewOrderedContentStrings array as well
                validOverviewOrderedContentStrings.append(string)
            }
        }
        // check for valid videosList strings
        if videosList.count != 0 {
            // set the validVideosListStrings array properties
            validVideosListStrings = videosList
            // loop through the array and append them to validOverviewOrderedContentStrings
            for tuple in videosList {
                validOverviewOrderedContentStrings.append(tuple)
            }
        }
        // check for valid readingsList strings
        if readingsList.count != 0 {
            // set the validReadingsListStrings array properties
            validReadingsListStrings = readingsList
            // loop through the array and append them to validOverviewOrderedContentStrings
            for tuple in readingsList {
                validOverviewOrderedContentStrings.append(tuple)
            }
        }
        // check for valid practiceSheets strings
        if practiceSheets.count != 0 {
            // set the validPracticeStrings array properties
            validPracticeSheetsStrings = practiceSheets
            // loop through the array and append them to validOverviewOrderedContentStrings
            for tuple in practiceSheets {
                validOverviewOrderedContentStrings.append(tuple)
            }
        }
        // check for valid supplementalMaterials strings
        if supplementalMaterials.count != 0 {
            // set the validSupplementalMaterialsStrings array properties
            validSupplementalMaterialsStrings = supplementalMaterials
            // loop through the array and append them to validOverviewOrderedContentStrings
            for tuple in supplementalMaterials {
                validOverviewOrderedContentStrings.append(tuple)
            }
        }
    }
}


