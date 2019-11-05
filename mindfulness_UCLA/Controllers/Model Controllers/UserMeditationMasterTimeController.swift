//
//  UserMeditationMasterTimeController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class UserMeditationMasterTimeModelController {
    
    // MARK: - Properties
    
    static let shared = UserMeditationMasterTimeModelController()
    
    // Timer properties
    var durationInSecondsAsInt: Int = 0
    var currentViewWillDisappearTime: Date!
    var timerStartTime: Date!
    var currentElapsedTime: TimeInterval = 0.00
    var isTimeRunning: Bool!
    var isTimerActive: Bool!
    
}
