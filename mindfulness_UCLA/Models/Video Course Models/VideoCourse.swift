//
//  VideoCourse.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/27/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class VideoCourse {
    
    // MARK: Properties
    
    var title: String
    var duration: String
    var url: String
    var thumbnailPath: String
    
    
    // MARK: Initialization
    init(title: String,
         duration: String,
         url: String,
         thumbnailPath: String
        ) {
        self.title = title
        self.duration = duration
        self.url = url
        self.thumbnailPath = thumbnailPath
    }
}

extension VideoCourse: Equatable {
    
    static func ==(lhs: VideoCourse, rhs: VideoCourse) -> Bool {
        if lhs.title != rhs.title { return false }
        if lhs.duration != rhs.duration { return false }
        if lhs.url != rhs.url { return false }
        if lhs.thumbnailPath != rhs.thumbnailPath { return false }
        
        return true
    }
}

