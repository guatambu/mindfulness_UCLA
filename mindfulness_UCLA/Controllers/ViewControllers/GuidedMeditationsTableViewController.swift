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
    
    let audioMeditations: [GuidedMeditation] = [BodyScan.metaData, Sitting.metaData, DifficultEmotions.metaData, PhysicalPain.metaData, Mountain.metaData, Lake.metaData, Lovingkindness.metaData, SootheSoftenAllow.metaData, RAIN.metaData, Silent.metaData]
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "guided meditations"
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
        <#code#>
    }

}
