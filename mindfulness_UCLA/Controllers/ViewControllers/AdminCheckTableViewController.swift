//
//  AdminCheckTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AdminCheckTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let meditationCounts: [Int] = [ GuidedMeditationsModelController.shared.raisinMeditationCount,
                        GuidedMeditationsModelController.shared.bodyScanMeditationCount,
                        GuidedMeditationsModelController.shared.sittingMeditationCount,
                        GuidedMeditationsModelController.shared.difficultEmotionsMeditationCount,
                        GuidedMeditationsModelController.shared.physicalPainMeditationCount,
                        GuidedMeditationsModelController.shared.mountainMeditationCount,
                        GuidedMeditationsModelController.shared.lakeMeditationCount,
                        GuidedMeditationsModelController.shared.lovingKindnessMeditationCount,
                        GuidedMeditationsModelController.shared.softenSootheAllowMeditationCount,
                        GuidedMeditationsModelController.shared.rainMeditationCount,
                        GuidedMeditationsModelController.shared.silentMeditationCount ]
    
    let meditations = [ RaisinMeditationVideo.metaData,
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
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meditations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminCheckCell", for: indexPath) 
        
        cell.textLabel?.text = meditations[indexPath.row].title
        
        cell.detailTextLabel?.text = "\(meditationCounts[indexPath.row])"

        return cell
    }
}
