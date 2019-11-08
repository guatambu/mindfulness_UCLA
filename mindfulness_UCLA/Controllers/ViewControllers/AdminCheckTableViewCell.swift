//
//  AdminCheckTableViewCell.swift
//  mindfulness_UCLA
//
//  Created by Miuchael Guatambu Davis on 11/7/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class AdminCheckTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var meditationTitleLabel: UILabel!
    @IBOutlet weak var meditationCountLabel: UILabel!
    
    var meditation: GuidedMeditation?
    
    var meditationCount: Int? {
        
        didSet{
            updateViews()
        }
    }

    
    // MARK: - awakeFromNib() 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    // MARK: - updateViews() function
    
    func updateViews() {
        
        guard let meditationsCount = meditationCount else {
            
            print("ERROR: nil vlaue found for meditationCount in AdminCheckTableViewCell.swift -> updateViews() - line 36.")
            
            return
        }
        
        guard let meditation = meditation else {
            
            print("ERROR: nil vlaue found for meditation in AdminCheckTableViewCell.swift -> updateViews() - line 43.")
            
            return
        }
        
        meditationTitleLabel.text = meditation.title
        
        meditationCountLabel.text = "\(meditationsCount)"
    }
}
