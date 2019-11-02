//
//  TimerModelController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/1/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class TimerModelController {
    
    // MARK: - Properties
    
    static let shared = TimerModelController()
    
    // Timer properties
    var sliderTimer: Timer?
    var timeInterval: TimeInterval = 0.00
    var secondsInts: Int = 0
    var isTimerRunning: Bool = false
    
    // MARK: - CRUD Functions
    
    func createTimer() {
        
    }
    
    func updateTimer() {
        
    }
    
    func stopTimer() {
        
    }

}
