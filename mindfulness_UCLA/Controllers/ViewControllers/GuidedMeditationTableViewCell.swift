//
//  GuidedMeditationTableViewCell.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/25/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class GuidedMeditationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var meditationTitleLabel: UILabel!
    @IBOutlet weak var meditationDurationLabel: UILabel!
    
    var meditation: GuidedMeditation? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: UpdateViews()
    
    func updateViews() {
        
        guard let meditation = meditation else {
            
            print("ERROR: nil value found for meditation object in GuidedMeditationTableViewCell.swift - updateViews() - line 36.")
            return
        }
        
        meditationTitleLabel.text = meditation.title
        meditationDurationLabel.text = meditation.duration
        
    }

}
