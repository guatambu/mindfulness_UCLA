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
    
    var meditationCounts: [Double] {
        
        var masterCount: [Double] = []
        
        let sourceOfTruth = GuidedMeditationsModelController.shared.counts[0] 
        
        masterCount = [ sourceOfTruth.raisin,
                        sourceOfTruth.bodyScan,
                        sourceOfTruth.sitting,
                        sourceOfTruth.difficultEmotions,
                        sourceOfTruth.physicalPain,
                        sourceOfTruth.mountain,
                        sourceOfTruth.lake,
                        sourceOfTruth.lovingKindness,
                        sourceOfTruth.sootheSoftenAllow,
                        sourceOfTruth.r_a_i_n,
                        sourceOfTruth.silent,
                        sourceOfTruth.yoga1,
                        sourceOfTruth.yoga2 ]
        
        return masterCount
    }
    
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
                        Silent.metaData,
                        MindfulYoga1.metaData,
                        MindfulYoga2.metaData ]
    
    
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
        
        cell.detailTextLabel?.text = "\(Int(meditationCounts[indexPath.row]))"

        return cell
    }
}
