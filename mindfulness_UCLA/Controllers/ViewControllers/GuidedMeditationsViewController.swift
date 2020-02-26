//
//  GuidedMeditationsViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/26/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import SafariServices

class GuidedMeditationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lefthandTrackProgressLabel: UILabel!
    @IBOutlet weak var righthandTrackDurationLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var meditationsTableView: UITableView!
    
    var isAudioPlayerPlaying: Bool = false
    var titleOfCurrentlyPlayingTrack: String = ""
    
    var sliderTimer: Timer?
    var trackLabelTimer: Timer?
    
    let audioMeditations: [GuidedMeditation] = [ RaisinMeditationVideo.metaData,
                                                 BodyScan.metaData,
                                                 Sitting.metaData,
                                                 DifficultEmotions.metaData,
                                                 PhysicalPain.metaData,
                                                 Mountain.metaData,
                                                 Lake.metaData,
                                                 Lovingkindness.metaData,
                                                 SootheSoftenAllow.metaData,
                                                 RAIN.metaData,
                                                 Silent.metaData ]
    
    let masterCount = GuidedMeditationsModelController.shared.counts[0]
    
    
    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
    
        guard let isPlaying = GuidedMeditationsModelController.shared.isGuidedMeditationPlaying else {

            print("isPlaying = \(String(describing: GuidedMeditationsModelController.shared.isGuidedMeditationPlaying))")

            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = false

            return
        }
        
        // setup player UI for currently playing track
        if isPlaying {

            if GuidedMeditationsModelController.audioPlayer.isPlaying {
                
                var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo!
            
                print("\(String(describing: nowPlayingInfo[MPMediaItemPropertyTitle]))")
                print("\(String(describing: nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime])))")
                print("\(String(describing: nowPlayingInfo[MPMediaItemPropertyPlaybackDuration])))")

                trackTitleLabel.text = nowPlayingInfo[MPMediaItemPropertyTitle] as? String

                trackSlider.isEnabled = true
                trackSlider.maximumValue = Float(GuidedMeditationsModelController.audioPlayer.duration)
                sliderTimer?.invalidate()
                sliderTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.sliderTracksProgress), userInfo: nil, repeats: true)
                trackLabelTimer?.invalidate()
                trackLabelTimer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(self.displayTrackProgress), userInfo: nil, repeats: true)
                righthandTrackDurationLabel.text = convertSecondsToMinutes(time: GuidedMeditationsModelController.audioPlayer.duration)

                playPauseButton.isEnabled = true
                playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)

                sliderTracksProgress()
                displayTrackProgress()
            }
        }
        
    }
    
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
        
        // set up MediaPlayer elements for remote controls on lockscreen, control panel
        setupRemoteTransportControls()
        // setup AVFoundation elements
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch {
            
            print("ERROR: problem while trying to set up AVAudioSession... \(error.localizedDescription) in GuidedMeditationsTableViewController.swift -> viewDidLoad() - line 115.")
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func trackSliderMoved(_ sender: UISlider, forEvent event: UIEvent) {
        
        GuidedMeditationsModelController.audioPlayer.stop()
        
        GuidedMeditationsModelController.audioPlayer.currentTime = TimeInterval(trackSlider.value)
        GuidedMeditationsModelController.audioPlayer.prepareToPlay()
        
        if let touchEvent = event.allTouches?.first {
            
            switch touchEvent.phase {
                
            case .ended:
                
                GuidedMeditationsModelController.audioPlayer.play()
                playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
                
            default:
                print("other touch events have been recorded")
            }
            
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        
        if let isPlaying = GuidedMeditationsModelController.shared.isGuidedMeditationPlaying {
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = !isPlaying
        }
        
        if GuidedMeditationsModelController.audioPlayer.isPlaying {
            
            GuidedMeditationsModelController.audioPlayer.pause()
            updateNowPlaying(isPause: true)
    
            playPauseButton.setImage(UIImage(named: "mindfulness-play-90"), for: UIControl.State.normal)
            
        } else {
            
            GuidedMeditationsModelController.audioPlayer.play()
            updateNowPlaying(isPause: false)
            
            playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return audioMeditations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "guidedMeditationsCell", for: indexPath) as? GuidedMeditationTableViewCell else {
            
            print("ERROR: nil value found for cell in GuidedMeditationTableViewController.swift - tableView(_ tableView: cellForRowAt:) - line 181.")
            return UITableViewCell()
            
        }
        
        // Configure the cell...
        let meditation = audioMeditations[indexPath.row]
        
        cell.meditation = meditation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let audioMeditationToPlay = audioMeditations[indexPath.row]
        
        switch audioMeditationToPlay.title {
         
        // 1
        case AudioGuidedMeditationMetaDataStrings.raisinMeditationTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.raisinMeditationCount += 1
            
            masterCount.raisin += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: masterCount.raisin, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = false
            
            let urlString = AudioGuidedMeditationMetaDataStrings.raisinMeditationPath.rawValue
            
            if let url = URL(string: urlString) {
                
                let safariVC = SFSafariViewController(url: url)
                
                safariVC.delegate = self
                
                self.present(safariVC, animated: true)
            }
            
         
        // 2
        case AudioGuidedMeditationMetaDataStrings.bodyScanMeditationTitle.rawValue:
        
//            GuidedMeditationsModelController.shared.bodyScanMeditationCount += 1
            
            masterCount.bodyScan += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: masterCount.bodyScan, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 3
        case AudioGuidedMeditationMetaDataStrings.sittingMeditationTitle.rawValue:
        
//            GuidedMeditationsModelController.shared.sittingMeditationCount += 1
            
            masterCount.sitting += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: masterCount.sitting, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 4
        case AudioGuidedMeditationMetaDataStrings.difficultEmotionsMeditationTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.difficultEmotionsMeditationCount += 1
            
            masterCount.difficultEmotions += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: masterCount.difficultEmotions, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 5
        case AudioGuidedMeditationMetaDataStrings.physicalPainMeditaitonTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.physicalPainMeditationCount += 1
            
            masterCount.physicalPain += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: masterCount.physicalPain, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 6
        case AudioGuidedMeditationMetaDataStrings.mountainMeditationTitle.rawValue:
        
//            GuidedMeditationsModelController.shared.mountainMeditationCount += 1
            
            masterCount.mountain += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: masterCount.mountain, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 7
        case AudioGuidedMeditationMetaDataStrings.lakeMeditationTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.lakeMeditationCount += 1
            
            masterCount.lake += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: masterCount.lake, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 8
        case AudioGuidedMeditationMetaDataStrings.lovingkindnessMeditaitonTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.lovingKindnessMeditationCount += 1
            
            masterCount.lovingKindness += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: masterCount.lovingKindness, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
        
        // 9
        case AudioGuidedMeditationMetaDataStrings.softenSootheAllowMeditationTitle.rawValue:
            
//             GuidedMeditationsModelController.shared.softenSootheAllowMeditationCount += 1
            
            masterCount.sootheSoftenAllow += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: masterCount.sootheSoftenAllow, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 10
        case AudioGuidedMeditationMetaDataStrings.RAINMeditationTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.rainMeditationCount += 1
            
            masterCount.r_a_i_n += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: masterCount.r_a_i_n, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
        // 11
        case AudioGuidedMeditationMetaDataStrings.silent30minGuidedMeditationTitle.rawValue:
            
//            GuidedMeditationsModelController.shared.silentMeditationCount += 1
            
            masterCount.silent += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: masterCount.silent, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: nil)
            
            GuidedMeditationsModelController.shared.isGuidedMeditationPlaying = true
            
            titleOfCurrentlyPlayingTrack = audioMeditationToPlay.title
            
            trackTitleLabel.text = titleOfCurrentlyPlayingTrack
            
            playLocalAudioMeditation(path: audioMeditationToPlay.path)
            
            setupNowPlaying(nowPlaying: titleOfCurrentlyPlayingTrack)
            
            
        default:
            print("ERROR: unlikely event of an Guided MEditaiton with an unknown title has been passed into the switch statement in GuidedMeditationsViewController.swift -> tableView(tableView: didSelectRowAt:) - line 249.")
        }
        
        if let isPlaying = GuidedMeditationsModelController.shared.isGuidedMeditationPlaying {
            
            if isPlaying {
                
                playPauseButton.setImage(UIImage(named: "mindfulness-pause-90"), for: UIControl.State.normal)
                // activate the player's appearance in the UI
                playPauseButton.isEnabled = true
                
                trackSlider.isEnabled = true
                trackSlider.maximumValue = Float(GuidedMeditationsModelController.audioPlayer.duration)
                
                sliderTimer?.invalidate()
                sliderTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.sliderTracksProgress), userInfo: nil, repeats: true)
                trackLabelTimer?.invalidate()
                trackLabelTimer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(self.displayTrackProgress), userInfo: nil, repeats: true)
                
                lefthandTrackProgressLabel.isEnabled = true
                righthandTrackDurationLabel.isEnabled = true
                
            }
        }
    }
}


// MARK: - AVAudioPlayer functions
extension GuidedMeditationsViewController: AVAudioPlayerDelegate {
    
    // AVAudioPaleyer Delegate funciton
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player did finish playing: \(flag)")
        if (flag) {
            updateNowPlaying(isPause: true)
            playPauseButton.setTitle("Play", for: UIControl.State.normal)
        }
    }
    
    // function that takes the GuidedMEditation.path string property and converts it to local file path string and passes to the audioPlayer object to play the track
    func playLocalAudioMeditation(path: String) {
        
        guard let localFilePath = Bundle.main.path(forResource: "\(path).mp3", ofType: nil) else {
            
            print("ERROR: nil value found for localFilePath in GuidedMeditationsTableViewController.swift -> playLocalAudioMeditation(path:) - line 460.")
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
            
            GuidedMeditationsModelController.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            GuidedMeditationsModelController.audioPlayer.delegate = self
            GuidedMeditationsModelController.audioPlayer.prepareToPlay()
            
            GuidedMeditationsModelController.audioPlayer.play()
            
        } catch {
            
            print("ERROR: problem while trying to set up audioPlayer and play local audio file... \(error.localizedDescription) in GuidedMeditationsTableViewController.swift -> playUsingAVAudioPlayer(url:) - line 486.")
        }
        
        lefthandTrackProgressLabel.text = "0:00"
        righthandTrackDurationLabel.text = convertSecondsToMinutes(time: GuidedMeditationsModelController.audioPlayer.duration)
    }
    
    // function to handle the slider progress matched to the progress of the track that is playing
    @objc func sliderTracksProgress() {
        
        trackSlider.value = Float(GuidedMeditationsModelController.audioPlayer.currentTime)
    }
    
    // function to handle the display of the proper track time progress numerically in the leftHandTrackProgressLabel and the track's total duration in the rightHandTrackDurationLabel
    @objc func displayTrackProgress() {
        
        lefthandTrackProgressLabel.text = convertSecondsToMinutes(time: GuidedMeditationsModelController.audioPlayer.currentTime)
        
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
    
    // functions to handle interruptions to audio playback (i.e. an incoming call, or plug/unplug headphones) and resume play or not after interruption
    func setupNotifications() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleInterruption),
                                       name: AVAudioSession.interruptionNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleRouteChange),
                                       name: AVAudioSession.routeChangeNotification,
                                       object: nil)
    }
    
    // handle interruption such as incoming call
    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }
        
        if type == .began {
            print("Interruption began")
            // Interruption began, take appropriate actions
        }
        else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption Ended - playback should resume
                    print("Interruption Ended - playback should resume")
                    play()
                } else {
                    // Interruption Ended - playback should NOT resume
                    print("Interruption Ended - playback should NOT resume")
                }
            }
        }
    }
    
    // handle change to playback environment (i.e. plug/unplug headphones)
    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
                return
        }
        switch reason {
        case .newDeviceAvailable:
            let session = AVAudioSession.sharedInstance()
            for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.headphones {
                print("headphones connected")
                DispatchQueue.main.sync {
                    self.play()
                }
                break
            }
        case .oldDeviceUnavailable:
            if let previousRoute =
                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                for output in previousRoute.outputs where output.portType == AVAudioSession.Port.headphones {
                    print("headphones disconnected")
                    DispatchQueue.main.sync {
                        self.pause()
                    }
                    break
                }
            }
        default: ()
        }
    }
    
    // set up for lock screen and control panel audio controls
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            print("Play command - is playing: \(GuidedMeditationsModelController.audioPlayer.isPlaying)")
            if !GuidedMeditationsModelController.audioPlayer.isPlaying {
                self.play()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            print("Pause command - is playing: \(GuidedMeditationsModelController.audioPlayer.isPlaying)")
            if GuidedMeditationsModelController.audioPlayer.isPlaying {
                self.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    func setupNowPlaying(nowPlaying title: String) {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = GuidedMeditationsModelController.audioPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = GuidedMeditationsModelController.audioPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = GuidedMeditationsModelController.audioPlayer.rate
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func play() {
        GuidedMeditationsModelController.audioPlayer.play()
        playPauseButton.setTitle("Pause", for: UIControl.State.normal)
        updateNowPlaying(isPause: false)
        print("Play - current time: \(GuidedMeditationsModelController.audioPlayer.currentTime) - is playing: \(GuidedMeditationsModelController.audioPlayer.isPlaying)")
    }
    
    func pause() {
        GuidedMeditationsModelController.audioPlayer.pause()
        playPauseButton.setTitle("Play", for: UIControl.State.normal)
        updateNowPlaying(isPause: true)
        print("Pause - current time: \(GuidedMeditationsModelController.audioPlayer.currentTime) - is playing: \(GuidedMeditationsModelController.audioPlayer.isPlaying)")
    }
    
    func updateNowPlaying(isPause: Bool) {
        // Define Now Playing Info
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo!
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = GuidedMeditationsModelController.audioPlayer.currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPause ? 0 : 1
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}


// MARK: - SafariServices SFSafariViewConttroller Delegate
extension GuidedMeditationsViewController: SFSafariViewControllerDelegate {
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
