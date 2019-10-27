//
//  GuidedMeditations.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/25/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class GuidedMeditation {
    
    // MARK: Properties
    
    var title: String
    var duration: String
    // local bundle.main.path
    var path: String
    
    
    // MARK: Initialization
    init(title: String,
         duration: String,
         path: String
        ) {
        self.title = title
        self.duration = duration
        self.path = path
    }
}

extension GuidedMeditation: Equatable {
    
    static func ==(lhs: GuidedMeditation, rhs: GuidedMeditation) -> Bool {
        if lhs.title != rhs.title { return false }
        if lhs.duration != rhs.duration { return false }
        if lhs.path != rhs.path { return false }
        
        return true
    }
}
