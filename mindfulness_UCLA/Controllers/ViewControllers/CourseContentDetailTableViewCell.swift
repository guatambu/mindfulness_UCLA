//
//  CourseContentDetailTableViewCell.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/12/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

// TODO: - here we are going to format each individual cell's content.  this will be where the majority of the formatting's and content display's heavy lifting will take place


import UIKit

class CourseContentDetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    // array that holds the valid checked string tuples used to present the overview details
    var tupleStrings: (String, String)? {
        
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - awakeFromNib()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Cell Formatting Functions
    func updateViews() {
        // run error check for valid tupleStrings property
        guard let tupleStrings = tupleStrings else {
            print("ERROR: nil vlaue found for tupleStrings property in CourseContentDetailTableViewCell.swift -> updateViews - line 41.")
            return
        }
        // success, so on to cell formatting
        if tupleStrings.0 != "" {

            // format the headingLabel
            headingLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.0)
            headingLabel.isHidden = false
            
        } else {
            // hide the headingLAbel
            headingLabel.isHidden = true
        }
        if tupleStrings.1 != "" {
            // format the bodyTextLabel
            bodyTextLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.1)
            bodyTextLabel.isHidden = false
            
        } else {
            // hide the bodyTextLabel
            bodyTextLabel.isHidden = true
        }
    }
    
    func applyStylesToRange(stringToFormat: String)  -> NSMutableAttributedString {
        // 1
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 0)
        let normalFont = UIFont.preferredFont(forTextStyle: .body)
        
        // 2
        let regexStr = "(\\*\\w+(\\s\\w+)*\\*)"
        let regex = try! NSRegularExpression(pattern: regexStr)
        let boldAttributes = [NSAttributedString.Key.font: boldFont]
        let normalAttributes = [NSAttributedString.Key.font: normalFont]
        
        // 3
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringToFormat)
        
        let searchRange = NSMakeRange(0, stringToFormat.count)
        
        regex.enumerateMatches(in: stringToFormat, range: searchRange) {
            match, flags, stop in
            
            if let matchRange = match?.range(at: 1) {
                attributedString.addAttributes(boldAttributes, range: matchRange)
                // 4
                let maxRange = matchRange.location + matchRange.length
                if maxRange + 1 < attributedString.length {
                    attributedString.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
                }
            }
        }
        return attributedString
    }
}
