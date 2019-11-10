//
//  GuidedMeditationsModelController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/1/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

//class GuidedMeditationsModelController {
//
//    // MARK: - Properties
//
//    static let shared = GuidedMeditationsModelController()
//
//    var raisinMeditationCount = 0
//    var bodyScanMeditationCount = 0
//    var sittingMeditationCount = 0
//    var difficultEmotionsMeditationCount = 0
//    var physicalPainMeditationCount = 0
//    var mountainMeditationCount = 0
//    var lakeMeditationCount = 0
//    var lovingKindnessMeditationCount = 0
//    var softenSootheAllowMeditationCount = 0
//    var rainMeditationCount = 0
//    var silentMeditationCount = 0
//}


import CoreData

class GuidedMeditationsModelController {
    
    // MARK: - Properties
    
    static let shared = GuidedMeditationsModelController()
    
    var counts: [GuidedMeditationCount] {
        let fetchRequest: NSFetchRequest<GuidedMeditationCount> = GuidedMeditationCount.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    var masterCount: GuidedMeditationCount?
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(count: GuidedMeditationCount) {
        GuidedMeditationsModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(count: GuidedMeditationCount) {
        
        if let moc = count.managedObjectContext {
            
            moc.delete(count)
            GuidedMeditationsModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(count: GuidedMeditationCount?,
                raisin: Double?,
                bodyScan: Double?,
                difficultEmotions: Double?,
                lake: Double?,
                lovingKindness: Double?,
                mountain: Double?,
                physicalPain: Double?,
                r_a_i_n: Double?,
                silent: Double?,
                sitting: Double?,
                sootheSoftenAllow: Double?,
                yoga1: Double?,
                yoga2: Double?) {
        
        guard let count = count else {
            
            print("ERROR: nil found for GuidedMeditaitonCount in GuidedMeditationsModelController.swift -> update(count:...) - line 89.")
            return
        }
        
        if let raisin = raisin {
            count.raisin = raisin
        }
        if let bodyScan = bodyScan {
            count.bodyScan = bodyScan
        }
        if let difficultEmotions = difficultEmotions {
            count.difficultEmotions = difficultEmotions
        }
        if let lake = lake {
            count.lake = lake
        }
        if let lovingKindness = lovingKindness {
            count.lovingKindness = lovingKindness
        }
        if let mountain = mountain {
            count.mountain = mountain
        }
        if let physicalPain = physicalPain {
            count.physicalPain = physicalPain
        }
        if let r_a_i_n = r_a_i_n {
            count.r_a_i_n = r_a_i_n
        }
        if let silent = silent {
            count.silent = silent
        }
        if let sitting = sitting {
            count.sitting = sitting
        }
        if let sootheSoftenAllow = sootheSoftenAllow {
            count.sootheSoftenAllow = sootheSoftenAllow
        }
        if let yoga1 = yoga1 {
            count.yoga1 = yoga1
        }
        if let yoga2 = yoga2 {
            count.yoga2 = yoga2
        }
        
        GuidedMeditationsModelController.shared.saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        
        do {
            try CoreDataStack.context.save()
        } catch {
            print("ERROR: there was an error saving to persitent store. \(error) \(error.localizedDescription)")
        }
    }
}

