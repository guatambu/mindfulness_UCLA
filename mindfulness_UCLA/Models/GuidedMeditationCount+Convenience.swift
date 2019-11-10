//
//  GuidedMeditationCount+Convenience.swift
//  mindfulness_UCLA
//
//  Created by Michael GUatambu Davis on 11/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension GuidedMeditationCount {
    
    
    
    // convenience initializer to allow creation of a GuidedMeditationCount object via Mindfulness's CoreDataStack's managedObjectContext
    convenience init(raisin: Double,
                     bodyScan: Double,
                     difficultEmotions: Double,
                     lake: Double,
                     lovingKindness: Double,
                     mountain: Double,
                     physicalPain: Double,
                     r_a_i_n: Double,
                     silent: Double,
                     sitting: Double,
                     sootheSoftenAllow: Double,
                     yoga1: Double,
                     yoga2: Double,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.raisin = raisin
        self.bodyScan = bodyScan
        self.difficultEmotions = difficultEmotions
        self.lake = lake
        self.lovingKindness = lovingKindness
        self.mountain = mountain
        self.physicalPain = physicalPain
        self.r_a_i_n = r_a_i_n
        self.silent = silent
        self.sitting = sitting
        self.sootheSoftenAllow = sootheSoftenAllow
        self.yoga1 = yoga1
        self.yoga2 = yoga2
    }
}
