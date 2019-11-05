//
//  MeditationTimerViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import UserNotifications

class MeditationTimerViewController: UIViewController {
    
    // MARK: Properties
    
    // UILabel(s) properties
    @IBOutlet weak var numericCountdownLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    // UIView(s) properties
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var countdownView: UIView!
    // UIButton(s) properties
    // only cancel button can toggle isTimerActive property to false
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    // // only start button can toggle isTimerActive property to true
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var twoMinutesButtonOutlet: UIButton!
    @IBOutlet weak var fiveMinutesButtonOutlet: UIButton!
    @IBOutlet weak var tenMinutesButtonOutlet: UIButton!
    // UISlider property
    @IBOutlet weak var minutesChoiceSlider: UISlider!
    
    // UIColor specs
    let startBlue: UIColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 0.85)
    let pauseOrange: UIColor = UIColor(red: 245/255, green: 176/255, blue: 66/255, alpha: 0.85)
    // Timer properties
    var sliderTimer: Timer?
    var timeInterval: TimeInterval = 0.00
    
    // NOTE: -
    // // only CANCEL button can toggle isTimerActive property to FALSE
    // // only START button can toggle isTimerActive property to TRUE
   
    
    // MARK: ViewControllers Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserMeditationMasterTimeModelController.shared.isTimerActive != nil {
            
            if UserMeditationMasterTimeModelController.shared.isTimerActive && UserMeditationMasterTimeModelController.shared.isTimeRunning {
                
                restartRunningTimer()
                
                if numericCountdownLabel.text != "0:00" {
                    
                    UserMeditationMasterTimeModelController.shared.isTimeRunning = true
                    
                    startButtonOutlet.isEnabled = false
                }
                
            } else if UserMeditationMasterTimeModelController.shared.isTimerActive && !UserMeditationMasterTimeModelController.shared.isTimeRunning {
                
                numericCountdownLabel.text = convertSecondsToMinutes(time: UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt)
                
                startButtonOutlet.isEnabled = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        UserMeditationMasterTimeModelController.shared.currentViewWillDisappearTime = Date()
        
        destroyScheduledTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "meditation timer"
        
        setupSlider()
        setupStartAndPauseButtons()
    }
    
    
    // MARK: Actions
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if UserMeditationMasterTimeModelController.shared.isTimerActive == nil && UserMeditationMasterTimeModelController.shared.isTimeRunning == nil {
            
            UserMeditationMasterTimeModelController.shared.isTimerActive = false
            UserMeditationMasterTimeModelController.shared.isTimeRunning = false
        }
        
        // checks for UI based on whether an active Timer is running
        if !UserMeditationMasterTimeModelController.shared.isTimerActive && !UserMeditationMasterTimeModelController.shared.isTimeRunning && startButtonOutlet.titleLabel?.text == "start" {
            
            UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = ((Int(timeInterval) / 10) * 10)
            
            scheduleNewTimer()
            
            scheduleNewLocalNotification()
            
            // ** only START button can toggle isTimerActive property to TRUE **
            UserMeditationMasterTimeModelController.shared.isTimerActive = true
            
            startButtonOutlet.setTitle("pause", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = pauseOrange
            
            cancelButtonOutlet.isEnabled = true
            
            minutesChoiceSlider.isEnabled = false
            
        } else if UserMeditationMasterTimeModelController.shared.isTimerActive && UserMeditationMasterTimeModelController.shared.isTimeRunning && startButtonOutlet.titleLabel?.text == "pause" {
            
            if sliderTimer != nil {
                
                destroyScheduledTimer()
            }
            
            destroyScheduledLocalNotifications()
            
            UserMeditationMasterTimeModelController.shared.isTimeRunning = false
            
            startButtonOutlet.setTitle("start", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = startBlue
            
            cancelButtonOutlet.isEnabled = true
        
        } else if UserMeditationMasterTimeModelController.shared.isTimerActive && !UserMeditationMasterTimeModelController.shared.isTimeRunning && startButtonOutlet.titleLabel?.text == "start" {
            
            scheduleNewTimer()
            
            scheduleNewLocalNotification()
            
            UserMeditationMasterTimeModelController.shared.isTimeRunning = true
            
            cancelButtonOutlet.isEnabled = true
            
            startButtonOutlet.setTitle("pause", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = pauseOrange
            
            cancelButtonOutlet.isEnabled = true
            
            minutesChoiceSlider.isEnabled = false
            
        } else {
            
            startButtonOutlet.setTitle("start", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = startBlue
            
            minutesChoiceSlider.isEnabled = true
            
            cancelButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        // ** only CANCEL button can toggle isTimerActive property to FALSE **
        UserMeditationMasterTimeModelController.shared.isTimerActive = false
        
        UserMeditationMasterTimeModelController.shared.isTimeRunning = false
        UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = 0
        
        // destroy local timer
        destroyScheduledTimer()

        // destroy local notification(s)
        destroyScheduledLocalNotifications()
        
        numericCountdownLabel.text = "0:00"
        
        startButtonOutlet.backgroundColor = startBlue
        startButtonOutlet.setTitle("start", for: UIControl.State.normal)
        startButtonOutlet.isEnabled = false
        
        minutesChoiceSlider.value = 0.00
        minutesChoiceSlider.isEnabled = true
        
        cancelButtonOutlet.isEnabled = false
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        timeInterval = Double(sender.value) * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    
    @IBAction func twoMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 2 * 60
        UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    @IBAction func fiveMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 5 * 60
        UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    @IBAction func tenMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 10 * 60
        UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
}


extension MeditationTimerViewController {
    
    // MARK: UI Helper Functions
    
    func setupStartAndPauseButtons() {
        
        startButtonOutlet.isEnabled = false
        startButtonOutlet.isHidden = false
        startButtonOutlet.layer.cornerRadius = 40
        startButtonOutlet.backgroundColor = startBlue
        
        cancelButtonOutlet.isEnabled = false
        cancelButtonOutlet.isHidden = false
        cancelButtonOutlet.layer.cornerRadius = 40
        cancelButtonOutlet.layer.borderWidth = 1
        cancelButtonOutlet.layer.borderColor = startBlue.cgColor
    }
    
    func setupSlider() {
        
        minutesChoiceSlider.minimumValue = 0.00
        minutesChoiceSlider.maximumValue = 60.00
        minutesChoiceSlider.setValue(0.00, animated: true)
        minutesChoiceSlider.minimumTrackTintColor = startBlue
    }
    
    // function to set the start timer value with round 10 second values
    func setInitialTimerValue(time inSeconds: TimeInterval) -> String {
        
        var initialTimerValue = ""
        
        var seconds = 0
        var minutes = 0
        
        minutes = Int(inSeconds) / 60
        seconds =  (((Int(inSeconds) % 60) / 10) * 10)
        
        if seconds < 10 {
            
            initialTimerValue = "\(minutes):0\(seconds)"
        } else {
            
            initialTimerValue = "\(minutes):\(seconds)"
        }
        
        return initialTimerValue
    }
    
    
    // function to take in a track's given TimeInterval value in seconds and convert that to minutes and seconds
    func convertSecondsToMinutes(time inSeconds: Int) -> String {
        
        var seconds = 0
        var minutes = 0
        
        var duration = ""
        
        minutes = Int(inSeconds) / 60
        seconds = Int(inSeconds) % 60
        
        if seconds < 10 {
            
            duration = "\(minutes):0\(seconds)"
        } else {
            
            duration = "\(minutes):\(seconds)"
        }
        
        return duration
    }
}


// MARK: - timer functions
extension MeditationTimerViewController {
        
    // functipn to allow timer value to update the minutesLabel.text value
    @objc func updateTimer() {
        
        UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt -= 1
        
//        print("MasterTimeMC.shared.secondsInts from background: \(UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt)")
        
        numericCountdownLabel.text = convertSecondsToMinutes(time: UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt)
        
        if UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt <= 0 {
            
            sliderTimer?.invalidate()
            
            self.cancelButtonOutlet.isEnabled = false
            self.startButtonOutlet.backgroundColor = self.startBlue
            self.startButtonOutlet.setTitle("start", for: UIControl.State.normal)
            self.startButtonOutlet.isEnabled = false
            
            self.minutesChoiceSlider.isEnabled = true
            self.minutesChoiceSlider.value = 0.00
            
            UserMeditationMasterTimeModelController.shared.isTimerActive = false
            UserMeditationMasterTimeModelController.shared.isTimeRunning = false
            sliderTimer = nil
        }
    }
    
    func scheduleNewTimer() {
        
        // schedule timer
        if sliderTimer == nil {
            
            let timer = Timer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            timer.tolerance = 0.1
            
            sliderTimer = timer
        }
        
        // set relevant start time properties in UserMeditationMasterTimeModelController.shared
        UserMeditationMasterTimeModelController.shared.isTimeRunning = true
        
        UserMeditationMasterTimeModelController.shared.timerStartTime = Date()
    }
    
    func restartRunningTimer() {
        
        // check to see if a meditation countdown timer is active
        if UserMeditationMasterTimeModelController.shared.isTimerActive && UserMeditationMasterTimeModelController.shared.isTimeRunning {
            
            UserMeditationMasterTimeModelController.shared.currentElapsedTime = Date().timeIntervalSince(UserMeditationMasterTimeModelController.shared.currentViewWillDisappearTime)
            
            UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt = UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt - Int(UserMeditationMasterTimeModelController.shared.currentElapsedTime)
            
            // check to ensure valid positive run time for durationInSecondsAsInt
            if UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt <= 0 {
                
                UserMeditationMasterTimeModelController.shared.isTimerActive = nil
                UserMeditationMasterTimeModelController.shared.isTimeRunning = nil
                // do not schedule a timer, the durationInSecondsAsInt has expired
                numericCountdownLabel.text = "0:00"
                
            } else {
                
                // scehdule timer based on time remaining on current "running" timer time left
                if sliderTimer == nil {
                    
                    let timer = Timer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
                    RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
                    timer.tolerance = 0.1
                    
                    sliderTimer = timer
                    // the timer is now and running and will be set isTimerRunning = true
                    UserMeditationMasterTimeModelController.shared.isTimeRunning = true
                    
                    numericCountdownLabel.text = convertSecondsToMinutes(time: UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt)
                }
                
                startButtonOutlet.setTitle("pause", for: UIControl.State.normal)
                startButtonOutlet.backgroundColor = pauseOrange
                
                // TODO: build actual pausing functionality to allow for timer to resume
                
                cancelButtonOutlet.isEnabled = true
                
                minutesChoiceSlider.isEnabled = false
            }
            
        } else {
            
            print("ERROR: either the timeIsRunning property is false, or the sliderTimer does not equal nil, or both in MeditationTimerViewController ->  viewWillAppear(_ animated:) - line 400.")
        }
    }
    
    func destroyScheduledTimer() {
        
        sliderTimer?.invalidate()
        sliderTimer = nil
    }
}


// MARK: - funcitons for local notifications
extension MeditationTimerViewController {
    
    func scheduleNewLocalNotification() {
        
        // schedule local notification
        let manager = LocalNotificationsManager()
        
        manager.notifications = [
            MyNotification(id: AudioGuidedMeditationMetaDataStrings.meditationDone.rawValue,
                           title: AudioGuidedMeditationMetaDataStrings.meditationDone.rawValue,
                           body: AudioGuidedMeditationMetaDataStrings.hopeYouEnjoyedIt.rawValue, soundFilePath: AudioGuidedMeditationMetaDataStrings.tibetanBells.rawValue + AudioGuidedMeditationMetaDataStrings.soundFileType.rawValue)
        ]
        
        manager.schedule(duration: UserMeditationMasterTimeModelController.shared.durationInSecondsAsInt)
    }
    
    func destroyScheduledLocalNotifications() {
        
        // destroy local notification(s)
        let center = UNUserNotificationCenter.current()
        
        print(center)
        
        center.removeDeliveredNotifications(withIdentifiers: [AudioGuidedMeditationMetaDataStrings.meditationDone.rawValue])
        center.removePendingNotificationRequests(withIdentifiers: [AudioGuidedMeditationMetaDataStrings.meditationDone.rawValue])
        
        print(center)
    }
}
