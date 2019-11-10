//
//  VideoCoursesTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices

class VideoCoursesTableViewController: UITableViewController,
                                       VideoCourseTableViewCellDelegate,
                                       SFSafariViewControllerDelegate {
    
    // MARK: - Properties
    
    let videoCourses: [GuidedMeditation] = [ MindfulYoga1.metaData, MindfulYoga2.metaData ]
    
    let masterCount = GuidedMeditationsModelController.shared.counts[0]
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "video courses"
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videoCourses.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCoursesCell", for: indexPath) as? VideoCoursesTableViewCell else {
            
            print("ERROR: nil value found for cell in VideoCourseTableViewController.swift - tableView(_ tableView: cellForRowAt:) - line 45.")
            
            return UITableViewCell()
        }

        // Configure the cell...
        cell.delegate = self
        
        let videoCourse = videoCourses[indexPath.row]
        
        cell.videoCourse = videoCourse

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: perhaps need to implement the switch to track the plays on these two videos by a user by adding these to the GuidedMeditationsModelController and creating the corresponding data models in the Guided MEditaitons folder in the Models Group
        
    }
    
    
    // MARK: VideoCourseTableViewCellDelegate functions
    
    func openWebViewButtonTapped(cell: VideoCoursesTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            
            print("ERROR: nil value found for indexPath in VideoCoursesTableViewController.swift -> openWebViewButtonTapped(cell:) - line 66.")
            return
        }
        
        let videoCourseToPlay = videoCourses[indexPath.row]
        
        let urlString = videoCourseToPlay.path
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
        
        // add to masterCount
        switch videoCourseToPlay.title {
            
        case VideoGuidedMeditationMetaDataStrings.yoga1Title.rawValue:
            
            masterCount.yoga1 += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: masterCount.yoga1, yoga2: nil)
            
        case VideoGuidedMeditationMetaDataStrings.yoga2Title.rawValue:
            
            masterCount.yoga2 += 1.00
            
            GuidedMeditationsModelController.shared.update(count: masterCount, raisin: nil, bodyScan: nil, difficultEmotions: nil, lake: nil, lovingKindness: nil, mountain: nil, physicalPain: nil, r_a_i_n: nil, silent: nil, sitting: nil, sootheSoftenAllow: nil, yoga1: nil, yoga2: masterCount.yoga2)
            
        default:
            print("ERROR: unlikely event of an Guided Meditaiton Yoga Vdeo Course with an unknown title has been passed into the switch statement in VideoCoursesTableViewController.swift -> openWebViewButtonTapped(cell:) - line 104.")
            
        }
    }
    
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
