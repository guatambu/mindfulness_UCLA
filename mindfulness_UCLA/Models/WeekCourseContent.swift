//
//  WeekCourseContent.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

struct WeekCourseContent{
    
    /* these are all of type Tuple of Strings */
    // the .0 being a heading/title, and the .1 being the body text of the paragraph
    var introTextParagraph1: (String, String)
    var introTextParagraph2: (String, String)?
    var introTextParagraph3: (String, String)?
    // videos text
    var videosTextParagraph1: (String, String)
    var videosTextParagraph2: (String, String)?
    var videosTextParagraph3: (String, String)?
    // readings text
    var readingsTextParagraph1: (String, String)
    var readingsTextParagraph2: (String, String)?
    var readingsTextParagraph3: (String, String)?
    // daily practices text
    var dailyPracticesTextParagraph1: (String, String)
    var dailyPracticesTextParagraph2: (String, String)?
    var dailyPracticesTextParagraph3: (String, String)?
    // miscellaneous text
    var miscellaneousTextParagraph1: (String, String)
    var miscellaneousTextParagraph2: (String, String)?
    var miscellaneousTextParagraph3: (String, String)?
    /* ...URLList properties: */
    // each section's array of the list of URLs as type Tuple (String, String) - (to start)
    // the .0 being a heading/title as a String, and the .1 being the URL as a String
    var weekVideoURLList: [(String, String)]
    var weekReadingURLList: [(String, String)]
    var supplementalMaterialsURLList: [(String, String)]
    /* practiceSheetsURLList: a place holder for the appropriate .pdf files associated with each week. */
    // it may be as simple as the string to call the file up from the App Resources folder
    // it is an array because it is possible to have more than one file
    // the .0 being a heading/title as a String, and the .1 being the file URL/path as a String
    var practiceSheetsURLList: [(String, String)]
    /* guidedMeditationPlaceholder is a place holder for the appropriate .mp3 audio file associated with each week. */
    // it may be as simple as the string to call the file up from the App Resources folder
    // it is an array because it is possible to have more than one file
    // the .0 being a heading/title as a String, and the .1 being the file URL/path as a String
    var guidedMeditationPlaceholder: [(String, String)]
}
