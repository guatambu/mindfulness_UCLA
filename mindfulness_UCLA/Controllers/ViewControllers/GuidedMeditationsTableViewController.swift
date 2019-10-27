//
//  GuidedMeditationsTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Kelly Johnson on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class GuidedMeditationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lefthandTrackProgressLabel: UILabel!
    @IBOutlet weak var righthandTrackDurationLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    
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
        
        title = "guided meditations"
    }
    
    
    // MARK: - Actions
    
    @IBAction func trackSliderMoved(_ sender: UISlider) {
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        
        // let currentTime = audioPlayer.currentTime
        
        if audioPlayer.isPlaying {
            
            audioPlayer.pause()
        } else {
            
            audioPlayer.play()  // atTime: currentTime)
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return audioMeditations.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "guidedMeditationsCell", for: indexPath) as? GuidedMeditationTableViewCell else {
            
            print("ERROR: nil value found for cell in GuidedMeditationTableViewController.swift - tableView(_ tableView: cellForRowAt:) - line 39.")
            return UITableViewCell()
            
        }

        // Configure the cell...
        let meditation = audioMeditations[indexPath.row]
        
        cell.meditation = meditation

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let audioMeditationToPlay = audioMeditations[indexPath.row]
        
        trackTitleLabel.text = audioMeditationToPlay.title
        
        playLocalAudioMeditation(path: audioMeditationToPlay.path)
    }
}


// MARK: - AVAudioPlayer functions
extension GuidedMeditationsTableViewController {
    
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
        righthandTrackDurationLabel.text = "\(audioPlayer.duration)"
    }
    
    // function to handle the slider progress matched to the progress of the track that is playing
    func sliderTracksProgress() {
        
    }
    
    // function to handle the display of the proper track time progress numerically in the leftHandTrackProgressLabel and the track's total duration in the rightHandTrackDurationLabel
    func displayTrackProgress() {
        
    }
}
