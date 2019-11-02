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
    @IBOutlet weak var numericCountdownLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    // UIView(s) properties
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var countdownView: UIView!
    // UIButton(s) properties
    @IBOutlet weak var cancelButtonOutlet: UIButton!
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
    var secondsInts: Int = 0
    var isTimerRunning: Bool = false
    // AVAudioPlayer
    var audioPlayer = AVAudioPlayer()
    var isAudioPlayerPlaying = false
    
    
    // MARK: ViewControllers Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        if sliderTimer != nil {
            
            print("********************************")
            print("found existing sliderTimer")
            print("********************************")
        } else {
            
            
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "meditation timer"
        
        setupSlider()
        setupStartAndPauseButtons()
        
        prepareLocalAudioMeditation(path: "tibetan-bells-end-meditation-timer")
    }
    
    // MARK: Actions
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        secondsInts = ((Int(timeInterval) / 10) * 10)
        
        print("\(secondsInts) seconds")
        
        isTimerRunning = !isTimerRunning
        
        if sliderTimer == nil {
            
            let timer = Timer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            timer.tolerance = 0.2
            
//            let timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            
            self.sliderTimer = timer
            
        }
        
        if isTimerRunning {
            
            startButtonOutlet.setTitle("pause", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = pauseOrange
            
            // TODO: build actual pausing functionality to allow for timer to resume
            
            cancelButtonOutlet.isEnabled = true
            
            minutesChoiceSlider.isEnabled = false
            
        } else {
            
            startButtonOutlet.setTitle("start", for: UIControl.State.normal)
            startButtonOutlet.backgroundColor = startBlue
            
            cancelButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        isTimerRunning = false
        
        sliderTimer?.invalidate()
        sliderTimer = nil
        
        numericCountdownLabel.text = "0:00"
        
        startButtonOutlet.backgroundColor = startBlue
        startButtonOutlet.setTitle("start", for: UIControl.State.normal)
        startButtonOutlet.isEnabled = false
        
        minutesChoiceSlider.value = 0.00
        minutesChoiceSlider.isEnabled = true
        
        cancelButtonOutlet.isEnabled = false
        
        if isAudioPlayerPlaying {
            
            audioPlayer.stop()
            isAudioPlayerPlaying = false
        }
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        timeInterval = Double(sender.value) * 60
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    
    @IBAction func twoMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 2 * 60
        secondsInts = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    @IBAction func fiveMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 5 * 60
        secondsInts = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
    
    @IBAction func tenMinutesButtonTapped(_ sender: UIButton) {
        
        timeInterval = 10 * 60
        secondsInts = Int(timeInterval)
        
        numericCountdownLabel.text = setInitialTimerValue(time: timeInterval)
        
        startButtonOutlet.isEnabled = true
        cancelButtonOutlet.isEnabled = true
    }
}


extension MeditationTimerViewController {
    
    // MARK: Helper Functions
    
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
    
    // functipn to allow timer value to update the minutesLabel.text value
    @objc func updateTimer() {
        
        secondsInts -= 1
        
        print("secondsInts from background: \(secondsInts)")
        
        numericCountdownLabel.text = convertSecondsToMinutes(time: secondsInts)
        
        if secondsInts == 0 {
            
            sliderTimer?.invalidate()
            
            audioPlayer.play()
            isAudioPlayerPlaying = true
            
            let alert = UIAlertController(title: "meditation complete", message: "hope you enjoyed it.", preferredStyle: UIAlertController.Style.alert)
            let done = UIAlertAction(title: "done", style: UIAlertAction.Style.default) { (action) in
                
                if self.audioPlayer.isPlaying {
                    
                    self.audioPlayer.stop()
                }
                
                self.cancelButtonOutlet.isEnabled = false
                self.startButtonOutlet.backgroundColor = self.startBlue
                self.startButtonOutlet.setTitle("start", for: UIControl.State.normal)
                self.startButtonOutlet.isEnabled = false
                
                self.minutesChoiceSlider.isEnabled = true
                self.minutesChoiceSlider.value = 0.00
                
                self.isTimerRunning = false
                self.sliderTimer = nil
            }
            
            alert.addAction(done)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // function that takes the GuidedMEditation.path string property and converts it to local file path string and passes to the audioPlayer object to play the track
    func prepareLocalAudioMeditation(path: String) {
        
        guard let localFilePath = Bundle.main.path(forResource: "\(path)", ofType: "mp3") else {
            
            print("ERROR: nil value found for localFilePath in MeditationTimerViewController.swift -> playLocalAudioMeditation(path:) - line 203.")
            return
        }
        
        let url = URL(fileURLWithPath: localFilePath)
            
        prepareUsingAVAudioPlayer(url: url)
         
    }
    
    // function to initiate the playing of a track given a local file URL
    func prepareUsingAVAudioPlayer(url: URL) {
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            audioPlayer.numberOfLoops = 8
            audioPlayer.prepareToPlay()
            
            
            
        } catch {
            
            print("ERROR: problem while trying to play local audio file... \(error.localizedDescription) in MeditationTimerViewController.swift -> playUsingAVAudioPlayer(url:) - line 226.")
        }
    }
}
