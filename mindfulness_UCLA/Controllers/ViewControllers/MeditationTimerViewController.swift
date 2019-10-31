//
//  MeditationTimerViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class MeditationTimerViewController: UIViewController {
    
    // MARK: Properties
    
    // UILabel(s) properties
    @IBOutlet weak var meditationTimerLabel: UILabel!
    @IBOutlet weak var numericCountdownLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    // UIView(s) properties
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var countdownView: UIView!
    // UIButton(s) properties
    @IBOutlet weak var startPauseButtonOutlet: UIButton!
    @IBOutlet weak var twoMinutesButtonOutlet: UIButton!
    @IBOutlet weak var fiveMinutesButtonOutlet: UIButton!
    @IBOutlet weak var tenMinutesButtonOutlet: UIButton!
    @IBOutlet weak var closeButtonOutlet: UIButton!
    // UISlider property
    @IBOutlet weak var minutesChoiceSlider: UISlider!
    
    var sliderTimer: Timer?
    var seconds: TimeInterval = 0.00
    
    var audioPlayer = AVAudioPlayer()
    
    
    // MARK: ViewControllers Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        setupPauseButton()
    }
    
    // MARK: Actions
    
    @IBAction func startPauseButtonTapped(_ sender: UIButton) {
        
        startPauseButtonOutlet.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("", for: UIControl.State.normal)
        
        sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        seconds = Double(sender.value) * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: seconds)
        
        startPauseButtonOutlet.isEnabled = true
        startPauseButtonOutlet.setImage(UIImage(), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("start", for: UIControl.State.normal)
    }
    
    
    @IBAction func twoMinutesButtonTapped(_ sender: UIButton) {
        
        seconds = 2 * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: seconds)
        
        startPauseButtonOutlet.isEnabled = true
        startPauseButtonOutlet.setImage(UIImage(), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("start", for: UIControl.State.normal)
    }
    
    @IBAction func fiveMinutesButtonTapped(_ sender: UIButton) {
        
        seconds = 5 * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: seconds)
        
        startPauseButtonOutlet.isEnabled = true
        startPauseButtonOutlet.setImage(UIImage(), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("start", for: UIControl.State.normal)
    }
    
    @IBAction func tenMinutesButtonTapped(_ sender: UIButton) {
        
        seconds = 10 * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: seconds)
        
        startPauseButtonOutlet.isEnabled = true
        startPauseButtonOutlet.setImage(UIImage(), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("start", for: UIControl.State.normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        // dismiss the modally presented meditation timer viewcontroller
        dismiss(animated: true, completion: nil)
    }
}


extension MeditationTimerViewController {
    
    // MARK: Helper Functions
    
    func setupPauseButton() {
        
        startPauseButtonOutlet.isEnabled = false
        startPauseButtonOutlet.setImage(UIImage(), for: UIControl.State.normal)
        startPauseButtonOutlet.setTitle("start", for: UIControl.State.normal)
    }
    
    func setupSlider() {
        
        minutesChoiceSlider.minimumValue = 0.00
        minutesChoiceSlider.maximumValue = 60.00
        minutesChoiceSlider.setValue(0.00, animated: true)
        
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
    func convertSecondsToMinutes(time inSeconds: TimeInterval) -> String {
        
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
    
    // functipn to allow timer value to update the minutesLabel.text value
    @objc func updateTimer() {
        
        seconds -= 1
        
        numericCountdownLabel.text = convertSecondsToMinutes(time: seconds)
    }
}
