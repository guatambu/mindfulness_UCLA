//
//  WeekCourseContent.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class WeekCourseContent{
    
    // MARK: Properties
    
    // week's lesson title properties
    var lessonTitle: String
    var lessonSubTitle: String?
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
    
    // MARK: Initialization
    init(lessonTitle: String,
         lessonSubTitle: String?,
         introTextParagraph1: (String, String),
         introTextParagraph2: (String, String)?,
         introTextParagraph3: (String, String)?,
         videosTextParagraph1: (String, String),
         videosTextParagraph2: (String, String)?,
         videosTextParagraph3: (String, String)?,
         readingsTextParagraph1: (String, String),
         readingsTextParagraph2: (String, String)?,
         readingsTextParagraph3: (String, String)?,
         dailyPracticesTextParagraph1: (String, String),
         dailyPracticesTextParagraph2: (String, String)?,
         dailyPracticesTextParagraph3: (String, String)?,
         miscellaneousTextParagraph1: (String, String),
         miscellaneousTextParagraph2: (String, String)?,
         miscellaneousTextParagraph3: (String, String)?,
         weekVideoURLList: [(String, String)],
         weekReadingURLList: [(String, String)],
         supplementalMaterialsURLList: [(String, String)],
         practiceSheetsURLList: [(String, String)]
        ) {
        self.lessonTitle = lessonTitle
        self.lessonSubTitle = lessonSubTitle
        self.introTextParagraph1 = introTextParagraph1
        self.introTextParagraph2 = introTextParagraph2
        self.introTextParagraph3 = introTextParagraph3
        self.videosTextParagraph1 = videosTextParagraph1
        self.videosTextParagraph2 = videosTextParagraph2
        self.videosTextParagraph3 = videosTextParagraph3
        self.readingsTextParagraph1 = readingsTextParagraph1
        self.readingsTextParagraph2 = readingsTextParagraph2
        self.readingsTextParagraph3 = readingsTextParagraph3
        self.dailyPracticesTextParagraph1 = dailyPracticesTextParagraph1
        self.dailyPracticesTextParagraph2 = dailyPracticesTextParagraph2
        self.dailyPracticesTextParagraph3 = dailyPracticesTextParagraph3
        self.miscellaneousTextParagraph1 = miscellaneousTextParagraph1
        self.miscellaneousTextParagraph2 = miscellaneousTextParagraph2
        self.miscellaneousTextParagraph3 = miscellaneousTextParagraph3
        self.weekVideoURLList = weekVideoURLList
        self.weekReadingURLList = weekReadingURLList
        self.supplementalMaterialsURLList = supplementalMaterialsURLList
        self.practiceSheetsURLList = practiceSheetsURLList
    }
}

extension WeekCourseContent: Equatable {
    
    static func ==(lhs: WeekCourseContent, rhs: WeekCourseContent) -> Bool {
        if lhs.lessonTitle != rhs.lessonTitle { return false }
        if lhs.lessonSubTitle != rhs.lessonSubTitle { return false }
        if lhs.introTextParagraph1 != rhs.introTextParagraph1 { return false }
        if lhs.introTextParagraph2 ?? ("", "") != rhs.introTextParagraph2 ?? ("", "") { return false }
        if lhs.introTextParagraph3 ?? ("", "") != rhs.introTextParagraph3 ?? ("", "") { return false }
        if lhs.videosTextParagraph1 != rhs.videosTextParagraph1 { return false }
        if lhs.videosTextParagraph2 ?? ("", "") != rhs.videosTextParagraph2 ?? ("", "") { return false }
        if lhs.videosTextParagraph3 ?? ("", "") != rhs.videosTextParagraph3 ?? ("", "") { return false }
        if lhs.readingsTextParagraph1 != rhs.readingsTextParagraph1 { return false }
        if lhs.readingsTextParagraph2 ?? ("", "") != rhs.readingsTextParagraph2 ?? ("", "") { return false }
        if lhs.readingsTextParagraph3 ?? ("", "") != rhs.readingsTextParagraph3 ?? ("", "") { return false }
        if lhs.dailyPracticesTextParagraph1 != rhs.dailyPracticesTextParagraph1 { return false }
        if lhs.dailyPracticesTextParagraph2 ?? ("", "") != rhs.dailyPracticesTextParagraph2 ?? ("", "") { return false }
        if lhs.dailyPracticesTextParagraph3 ?? ("", "") != rhs.dailyPracticesTextParagraph3 ?? ("", "") { return false }
        if lhs.miscellaneousTextParagraph1 != rhs.miscellaneousTextParagraph1 { return false }
        if lhs.miscellaneousTextParagraph2 ?? ("", "") != rhs.miscellaneousTextParagraph2 ?? ("", "") { return false }
        if lhs.miscellaneousTextParagraph3 ?? ("", "") != rhs.miscellaneousTextParagraph3 ?? ("", "") { return false }
        
        return true
    }
}
