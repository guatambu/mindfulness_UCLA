//
//  GuidedMeditationsViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/26/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class GuidedMeditationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lefthandTrackProgressLabel: UILabel!
    @IBOutlet weak var righthandTrackDurationLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var meditationsTableView: UITableView!
    
    var sliderTimer: Timer?
    var trackLabelTimer: Timer?
    
    var audioPlayer = AVAudioPlayer()
    
    let audioMeditations: [GuidedMeditation] = [BodyScan.metaData,
                                                Sitting.metaData,
                                                DifficultEmotions.metaData,
                                                PhysicalPain.metaData,
                                                Mountain.metaData,
                                                Lake.metaData,
                                                Lovingkindness.metaData,
                                                SootheSoftenAllow.metaData,
                                                RAIN.metaData,
                                                Silent.metaData]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meditationsTableView.delegate = self
        meditationsTableView.dataSource = self
        
        title = "guided meditations"
        
        playPauseButton.isEnabled = false
        // deactivate the player's appearance in the UI
        trackSlider.setValue(0.00, animated: true)
        trackSlider.isEnabled = false
        lefthandTrackProgressLabel.isEnabled = false
        righthandTrackDurationLabel.isEnabled = false

    }
    
    
    // MARK: - Actions
    
    @IBAction func trackSliderMoved(_ sender: UISlider, forEvent event: UIEvent) {
        
        audioPlayer.stop()
        
        audioPlayer.currentTime = TimeInterval(trackSlider.value)
        audioPlayer.prepareToPlay()
        
        if let touchEvent = event.allTouches?.first {
            
            switch touchEvent.phase {
                
            case .ended:
                
                audioPlayer.play()
                playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
                
            default:
                print("other touch events have been recorded")
            }
            
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        
        // let currentTime = audioPlayer.currentTime
        
        if audioPlayer.isPlaying {
            
            audioPlayer.pause()
    
            playPauseButton.setImage(UIImage(named: "mindfulness-play-90"), for: UIControl.State.normal)
            
        } else {
            
            audioPlayer.play()
            
            playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return audioMeditations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "guidedMeditationsCell", for: indexPath) as? GuidedMeditationTableViewCell else {
            
            print("ERROR: nil value found for cell in GuidedMeditationTableViewController.swift - tableView(_ tableView: cellForRowAt:) - line 39.")
            return UITableViewCell()
            
        }
        
        // Configure the cell...
        let meditation = audioMeditations[indexPath.row]
        
        cell.meditation = meditation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let audioMeditationToPlay = audioMeditations[indexPath.row]
        
        trackTitleLabel.text = audioMeditationToPlay.title
        
        playLocalAudioMeditation(path: audioMeditationToPlay.path)
        
        switch audioMeditationToPlay.title {
            
        case AudioGuidedMeditationMetaDataStrings.bodyScanMeditationTitle.rawValue:
        
            GuidedMeditationsModelController.bodyScanMeditationCount += 1
            
        // 2
        case AudioGuidedMeditationMetaDataStrings.sittingMeditationTitle.rawValue:
        
            GuidedMeditationsModelController.sittingMeditationCount += 1
            
        // 3
        case AudioGuidedMeditationMetaDataStrings.difficultEmotionsMeditationTitle.rawValue:
            
            GuidedMeditationsModelController.difficultEmotionsMeditationCount += 1
            
        // 4
        case AudioGuidedMeditationMetaDataStrings.physicalPainMeditaitonTitle.rawValue:
            
            GuidedMeditationsModelController.physicalPainMeditationCount += 1
            
        // 5
        case AudioGuidedMeditationMetaDataStrings.mountainMeditationTitle.rawValue:
        
            GuidedMeditationsModelController.mountainMeditationCount += 1
            
        // 6
        case AudioGuidedMeditationMetaDataStrings.lakeMeditationTitle.rawValue:
            
            GuidedMeditationsModelController.lakeMeditationCount += 1
            
        // 7
        case AudioGuidedMeditationMetaDataStrings.lovingkindnessMeditaitonTitle.rawValue:
            
            GuidedMeditationsModelController.lovingKindnessMeditationCount += 1
        
        // 8
        case AudioGuidedMeditationMetaDataStrings.softenSootheAllowMeditationTitle.rawValue:
            
            GuidedMeditationsModelController.softenSootheAllowMeditationCount += 1
            
        // 9
        case AudioGuidedMeditationMetaDataStrings.RAINMeditationTitle.rawValue:
            
            GuidedMeditationsModelController.rainMeditationCount += 1
            
        // 10
        case AudioGuidedMeditationMetaDataStrings.silent30minGuidedMeditationTitle.rawValue:
            
            GuidedMeditationsModelController.silentMeditationCount += 1
            
            
        default:
            print("ERROR: unlikely event of an Guided MEditaiton with an unknown title has been passed into the switch statement in GuidedMeditationsViewController.swift -> tableView(tableView: didSelectRowAt:) - line 170.")
        }
        
        playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
        // activate the player's appearance in the UI
        playPauseButton.isEnabled = true
        
        trackSlider.isEnabled = true
        trackSlider.maximumValue = Float(audioPlayer.duration)
        
        sliderTimer?.invalidate()
        sliderTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.sliderTracksProgress), userInfo: nil, repeats: true)
        trackLabelTimer?.invalidate()
        trackLabelTimer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(self.displayTrackProgress), userInfo: nil, repeats: true)
        
        lefthandTrackProgressLabel.isEnabled = true
        righthandTrackDurationLabel.isEnabled = true
        
    }
}


// MARK: - AVAudioPlayer functions
extension GuidedMeditationsViewController {
    
    // function that takes the GuidedMEditation.path string property and converts it to local file path string and passes to the audioPlayer object to play the track
    func playLocalAudioMeditation(path: String) {
        
        guard let localFilePath = Bundle.main.path(forResource: "\(path)", ofType: "mp3") else {
            
            print("ERROR: nil value found for localFilePath in GuidedMeditationsTableViewController.swift -> playLocalAudioMeditation(path:) - line 102.")
            return
        }
        
        let url = URL(fileURLWithPath: localFilePath)
        
        playUsingAVAudioPlayer(url: url)
    }
    
    // function to initiate the playing of a track given a local file URL
    func playUsingAVAudioPlayer(url: URL) {
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            audioPlayer.play()
            
        } catch {
            
            print("ERROR: problem while trying to play local audio file... \(error.localizedDescription) in GuidedMeditationsTableViewController.swift -> playUsingAVAudioPlayer(url:) - line 121.")
        }
        
        lefthandTrackProgressLabel.text = "0:00"
        righthandTrackDurationLabel.text = convertSecondsToMinutes(time: audioPlayer.duration)
    }
    
    // function to handle the slider progress matched to the progress of the track that is playing
    @objc func sliderTracksProgress() {
        
        trackSlider.value = Float(audioPlayer.currentTime)
    }
    
    // function to handle the display of the proper track time progress numerically in the leftHandTrackProgressLabel and the track's total duration in the rightHandTrackDurationLabel
    @objc func displayTrackProgress() {
        
        lefthandTrackProgressLabel.text = convertSecondsToMinutes(time: audioPlayer.currentTime)
        
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
}
