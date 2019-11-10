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

        let resetItem = UIBarButtonItem(title: "reset", style: UIBarButtonItem.Style.plain, target: self, action: #selector(resetMasterCount))
        navigationItem.rightBarButtonItem = resetItem
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
    
    
    // MARK: - helper funtions
    
    // funciton that resets the guided meditations master count across all the various guided meditations.  a complete reset.
    @objc func resetMasterCount() {
        
        let alert = UIAlertController(title: "Master Count Reset", message: "are you sure you want to reset the master count?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.destructive, handler: nil)
        
        let pleaseReset = UIAlertAction(title: "please reset", style: UIAlertAction.Style.default) { (action) in
            
            GuidedMeditationsModelController.shared.update(count: GuidedMeditationsModelController.shared.counts[0], raisin: 0.0, bodyScan: 0.0, difficultEmotions: 0.0, lake: 0.0, lovingKindness: 0.0, mountain: 0.0, physicalPain: 0.0, r_a_i_n: 0.0, silent: 0.0, sitting: 0.0, sootheSoftenAllow: 0.0, yoga1: 0.0, yoga2: 0.0)
        }
        
        alert.addAction(cancel)
        alert.addAction(pleaseReset)
        
        present(alert, animated: true, completion: nil)
    }
}
