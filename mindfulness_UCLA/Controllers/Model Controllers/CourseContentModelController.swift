//
//  CourseContentModelController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class CourseContentModelController {
    
    // MARK: - Properties
    
    static let shared = CourseContentModelController()
    
    var courses = [Week1Data.courseContent,
                   Week2Data.courseContent,
                   Week3Data.courseContent,
                   Week4Data.courseContent,
                   Week5Data.courseContent,
                   Week6Data.courseContent,
                   Week7Data.courseContent,
                   Week8Data.courseContent,
                   Week9Data.courseContent]

    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(lessonTitle: String,
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
                practiceSheetsURLList: [(String, String)],
                guidedMeditationPlaceholder: [(String, String)]) {
        
        let weekCourseContent = WeekCourseContent(lessonTitle: lessonTitle,
                                              lessonSubTitle: lessonSubTitle,
                                              introTextParagraph1: introTextParagraph1,
                                              introTextParagraph2: introTextParagraph2,
                                              introTextParagraph3: introTextParagraph3,
                                              videosTextParagraph1: videosTextParagraph1,
                                              videosTextParagraph2: videosTextParagraph2,
                                              videosTextParagraph3: videosTextParagraph3,
                                              readingsTextParagraph1: readingsTextParagraph1,
                                              readingsTextParagraph2: readingsTextParagraph2,
                                              readingsTextParagraph3: readingsTextParagraph3,
                                              dailyPracticesTextParagraph1: dailyPracticesTextParagraph1,
                                              dailyPracticesTextParagraph2: dailyPracticesTextParagraph2,
                                              dailyPracticesTextParagraph3: dailyPracticesTextParagraph3,
                                              miscellaneousTextParagraph1: miscellaneousTextParagraph1,
                                              miscellaneousTextParagraph2: miscellaneousTextParagraph2,
                                              miscellaneousTextParagraph3: miscellaneousTextParagraph3,
                                              weekVideoURLList: weekVideoURLList,
                                              weekReadingURLList: weekReadingURLList,
                                              supplementalMaterialsURLList: supplementalMaterialsURLList,
                                              practiceSheetsURLList: practiceSheetsURLList,
                                              guidedMeditationPlaceholder: guidedMeditationPlaceholder)
        
        courses.append(weekCourseContent)
    }
    
    // Read
    
    // Update
    func updateProfileInfo(course: WeekCourseContent,
                           lessonTitle: String?,
                           lessonSubTitle: String?,
                           introTextParagraph1: (String, String)?,
                           introTextParagraph2: (String, String)?,
                           introTextParagraph3: (String, String)?,
                           videosTextParagraph1: (String, String)?,
                           videosTextParagraph2: (String, String)?,
                           videosTextParagraph3: (String, String)?,
                           readingsTextParagraph1: (String, String)?,
                           readingsTextParagraph2: (String, String)?,
                           readingsTextParagraph3: (String, String)?,
                           dailyPracticesTextParagraph1: (String, String)?,
                           dailyPracticesTextParagraph2: (String, String)?,
                           dailyPracticesTextParagraph3: (String, String)?,
                           miscellaneousTextParagraph1: (String, String)?,
                           miscellaneousTextParagraph2: (String, String)?,
                           miscellaneousTextParagraph3: (String, String)?,
                           weekVideoURLList: [(String, String)]?,
                           weekReadingURLList: [(String, String)]?,
                           supplementalMaterialsURLList: [(String, String)]?,
                           practiceSheetsURLList: [(String, String)]?,
                           guidedMeditationPlaceholder: [(String, String)]?
        ) {
        
        if let lessonTitle = lessonTitle {
            course.lessonTitle = lessonTitle
        }
        
        if let lessonSubTitle = lessonSubTitle {
            course.lessonSubTitle = lessonSubTitle
        }
        if let introTextParagraph1 = introTextParagraph1 {
            course.introTextParagraph1 = introTextParagraph1
        }
        if let introTextParagraph2 = introTextParagraph2 {
            course.introTextParagraph2 = introTextParagraph2
        }
        if let introTextParagraph3 = introTextParagraph3 {
            course.introTextParagraph3 = introTextParagraph3
        }
        if let videosTextParagraph1 = videosTextParagraph1 {
            course.videosTextParagraph1 = videosTextParagraph1
        }
        if let videosTextParagraph2 = videosTextParagraph2 {
            course.videosTextParagraph2 = videosTextParagraph2
        }
        if let videosTextParagraph3 = videosTextParagraph3 {
            course.videosTextParagraph3 = videosTextParagraph3
        }
        if let readingsTextParagraph1 = readingsTextParagraph1 {
            course.readingsTextParagraph1 = readingsTextParagraph1
        }
        if let readingsTextParagraph2 = readingsTextParagraph2 {
            course.readingsTextParagraph2 = readingsTextParagraph2
        }
        if let readingsTextParagraph3 = readingsTextParagraph3 {
            course.readingsTextParagraph3 = readingsTextParagraph3
        }
        if let dailyPracticesTextParagraph1 = dailyPracticesTextParagraph1 {
            course.dailyPracticesTextParagraph1 = dailyPracticesTextParagraph1
        }
        if let dailyPracticesTextParagraph2 = dailyPracticesTextParagraph2 {
            course.dailyPracticesTextParagraph2 = dailyPracticesTextParagraph2
        }
        if let dailyPracticesTextParagraph3 = dailyPracticesTextParagraph3 {
            course.dailyPracticesTextParagraph3 = dailyPracticesTextParagraph3
        }
        if let miscellaneousTextParagraph1 = miscellaneousTextParagraph1 {
            course.miscellaneousTextParagraph1 = miscellaneousTextParagraph1
        }
        if let miscellaneousTextParagraph2 = miscellaneousTextParagraph2 {
            course.miscellaneousTextParagraph2 = miscellaneousTextParagraph2
        }
        if let miscellaneousTextParagraph3 = miscellaneousTextParagraph3 {
            course.miscellaneousTextParagraph3 = miscellaneousTextParagraph3
        }
        if let weekVideoURLList = weekVideoURLList {
            course.weekVideoURLList = weekVideoURLList
        }
        if let weekReadingURLList = weekReadingURLList {
            course.weekReadingURLList = weekReadingURLList
        }
        if let supplementalMaterialsURLList = supplementalMaterialsURLList {
            course.supplementalMaterialsURLList = supplementalMaterialsURLList
        }
        if let practiceSheetsURLList = practiceSheetsURLList {
            course.practiceSheetsURLList = practiceSheetsURLList
        }
        if let guidedMeditationPlaceholder = guidedMeditationPlaceholder {
            course.guidedMeditationPlaceholder = guidedMeditationPlaceholder
        }
    }
    
    // Delete
    func delete(course: WeekCourseContent) {
        guard let index = self.courses.firstIndex(of: course) else { return }
        self.courses.remove(at: index)
    }
    
}
