//
//  CourseContentDetailTableViewCell.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/12/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class CourseContentDetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var openWebViewButton: UIButton!
    
    var isLinkActive: Bool?
    var isPDFFile: Bool?
    
    var delegate: CourseContentDetailsTableViewCellDelegate?
    
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
            print("ERROR: nil vlaue found for tupleStrings or isLinkActive property in CourseContentDetailTableViewCell.swift -> updateViews - line 46.")
            return
        }
        guard let isLinkActive = isLinkActive else {
            print("ERROR: nil vlaue found for isLinkActive or isLinkActive property in CourseContentDetailTableViewCell.swift -> updateViews - line 49.")
            return
        }
        guard let isPDFFile = isPDFFile else {
            print("ERROR: nil vlaue found for isPDFFile or isLinkActive property in CourseContentDetailTableViewCell.swift -> updateViews - line 52.")
            return
        }
        

        print("isLinkActive: \(isLinkActive)")
        
        // success, so on to cell formatting
        if tupleStrings.0 != "" {
                
            // format the headingLabel
            headingLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.0)
            headingLabel.isHidden = false
            // hide the button
            openWebViewButton.isHidden = true
            openWebViewButton.isEnabled = false
            
        
        } else {
            // hide the headingLabel
            headingLabel.isHidden = true
        }
        
        if tupleStrings.1 != "" {
            
            if tupleStrings.1.contains("http") && isLinkActive {
                
                // format the headingLabel
                headingLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.0)
                // hide the headingLabel
                headingLabel.isHidden = false
                // hide the bodyTextLabel
                bodyTextLabel.isHidden = true
                // show the button
                openWebViewButton.isHidden = false
                openWebViewButton.isEnabled = true
                openWebViewButton.setTitle("", for: UIControl.State.normal)
                
            } else if tupleStrings.1.contains("http") && !isLinkActive {
                
                // format the headingLabel
                headingLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.0)
                // hide the headingLabel
                headingLabel.isHidden = false
                // hide the bodyTextLabel
                bodyTextLabel.isHidden = true
                // hide the button
                openWebViewButton.isHidden = true
                openWebViewButton.isEnabled = false
                
            } else if isPDFFile {
                
                // format the headingLabel
                headingLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.0)
                // hide the headingLabel
                headingLabel.isHidden = false
                // hide the bodyTextLabel
                bodyTextLabel.isHidden = true
                // show the button
                openWebViewButton.isHidden = false
                openWebViewButton.isEnabled = true
                openWebViewButton.setTitle("", for: UIControl.State.normal)
                
            } else {
                
                // show the bodyTextLabel
                bodyTextLabel.isHidden = false
                // format the bodyTextLabel
                bodyTextLabel.attributedText = applyStylesToRange(stringToFormat: tupleStrings.1)
                // hide the button
                openWebViewButton.isHidden = true
                openWebViewButton.isEnabled = false
    
            }
            
        } else {
            // hide the bodyTextLabel
            bodyTextLabel.isHidden = true
        }
    }
    
    
    // MARK: Actions
    
    // function to present modally a webView
    @IBAction func openWebViewButtonTapped(_ sender: UIButton) {
        
        delegate?.openWebViewButtonTapped(cell: self)
    }
}


// MARK: - NSRegularExpression and text typeface formatting functions
extension CourseContentDetailTableViewCell {
    
    // MARK: Helper Functions
    
    // function to provide necessary text formatting/styling to text in a String type
    // convert string type to an attributed NSMutableAttributedString type
    // returns the NSMutableAttributedString
    func applyStylesToRange(stringToFormat: String)  -> NSMutableAttributedString {
        
        // create bold typeface font attribute
        let boldFontDescriptor = UIFontDescriptor.init(name: "GillSans", size: 20)
        let boldFont = UIFont(descriptor: boldFontDescriptor, size: 20)
        let boldAttributes = [NSAttributedString.Key.font: boldFont]
        
        // create italic typeface font attribute
        let italicFontDescriptor = UIFontDescriptor.init(name: "GillSans-LightItalic", size: 20)
        let italicFont = UIFont(descriptor: italicFontDescriptor, size: 20)
        let italicAttributes = [NSAttributedString.Key.font: italicFont]
        
        // create bold italics typeface font attributes
        let boldItalicFontDescriptor = UIFontDescriptor.init(name: "GillSans-Italic", size: 20)
        let boldItalicFont = UIFont(descriptor: boldItalicFontDescriptor, size: 20)
        let boldItalicAttributes = [NSAttributedString.Key.font: boldItalicFont]
        
        // create small italics typeface font attributes
        let smallItalicFontDescriptor = UIFontDescriptor.init(name: "GillSans-LightItalic", size: 16)
        let smallItalicFont = UIFont(descriptor: smallItalicFontDescriptor, size: 16)
        let smallItalicAttributes = [NSAttributedString.Key.font: smallItalicFont]
        
        // now pursue the string formatting search
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringToFormat)
        
        let range = NSMakeRange(0, stringToFormat.utf16.count)
        
        var charactersRemovedFromString = 0
        
        
        let boldRegex = try! NSRegularExpression(pattern: RegExPatterns.boldPattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        
        let boldMatches = boldRegex.matches(in: stringToFormat, options: [], range: range)
        
        print("stringToFormat: \(stringToFormat)")
        print("stringToFormat.count: \(stringToFormat.count)")
        print("boldMatches: \(boldMatches)")
        
        var boldCounter = 0
        
        for match in boldMatches {
            
            print("i: \(boldCounter)")
            print("charactersRemovedFromString: \(charactersRemovedFromString)")
            
            if boldCounter == 0 {
                
                charactersRemovedFromString = 0
            }
            
            let newRange = NSMakeRange(match.range.location - charactersRemovedFromString, match.range.length)
            
            attributedString.addAttributes(boldAttributes, range:newRange)
            
            let rangeOfFirstCharacter = NSMakeRange(match.range.location - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfFirstCharacter, with: "")
            
            charactersRemovedFromString += 2
            boldCounter += 1
            
            let rangeOfLastCharacter = NSMakeRange(match.range.location + match.range.length - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfLastCharacter, with: "")
            
        }
        
        let italicsRegex = try! NSRegularExpression(pattern: RegExPatterns.italicPattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        
        let italicStringToFormat = attributedString.string
        
        let italicRange = NSMakeRange(0, italicStringToFormat.utf16.count)
        
        let italicMatches = italicsRegex.matches(in: italicStringToFormat, options: [], range: italicRange)
        
        var italicCounter = 0
        
        for match in italicMatches {
            
            if italicCounter == 0 {
                
                charactersRemovedFromString = 0
            }
            
            print("n: \(italicCounter)")
            print("charactersRemovedFromString: \(charactersRemovedFromString)")
            
            let newRange = NSMakeRange(match.range.location - charactersRemovedFromString, match.range.length)
            
            attributedString.addAttributes(italicAttributes, range:newRange)
            
            let rangeOfFirstCharacter = NSMakeRange(match.range.location - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfFirstCharacter, with: "")
            
            charactersRemovedFromString += 2
            italicCounter += 1
            
            let rangeOfLastCharacter = NSMakeRange(match.range.location + match.range.length - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfLastCharacter, with: "")
        }
        
        let smallItalicRegex = try! NSRegularExpression(pattern: RegExPatterns.smallItalicPattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        
        let smallItalicStringToFormat = attributedString.string
        
        let smallItalicRange = NSMakeRange(0, smallItalicStringToFormat.utf16.count)
        
        let smallItalicMatches = smallItalicRegex.matches(in: smallItalicStringToFormat, options: [], range: smallItalicRange)
        
        var smallItalicCounter = 0
        
        for match in smallItalicMatches {
            
            if smallItalicCounter == 0 {
                
                charactersRemovedFromString = 0
            }
            
            print("n: \(smallItalicCounter)")
            print("charactersRemovedFromString: \(charactersRemovedFromString)")
            
            let newRange = NSMakeRange(match.range.location - charactersRemovedFromString, match.range.length)
            
            attributedString.addAttributes(smallItalicAttributes, range:newRange)
            
            let rangeOfFirstCharacter = NSMakeRange(match.range.location - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfFirstCharacter, with: "")
            
            charactersRemovedFromString += 2
            smallItalicCounter += 1
            
            let rangeOfLastCharacter = NSMakeRange(match.range.location + match.range.length - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfLastCharacter, with: "")
        }
        
        let boldItalicRegex = try! NSRegularExpression(pattern: RegExPatterns.boldItalicPattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        
        let boldItalicStringToFormat = attributedString.string
        
        let boldItalicRange = NSMakeRange(0, boldItalicStringToFormat.utf16.count)
        
        let boldItalicMatches = boldItalicRegex.matches(in: boldItalicStringToFormat, options: [], range: boldItalicRange)
        
        var boldItalicCounter = 0
        
        for match in boldItalicMatches {
            
            if boldItalicCounter == 0 {
                
                charactersRemovedFromString = 0
            }
            
            print("n: \(boldItalicCounter)")
            print("charactersRemovedFromString: \(charactersRemovedFromString)")
            
            let newRange = NSMakeRange(match.range.location - charactersRemovedFromString, match.range.length)
            
            attributedString.addAttributes(boldItalicAttributes, range:newRange)
            
            let rangeOfFirstCharacter = NSMakeRange(match.range.location - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfFirstCharacter, with: "")
            
            charactersRemovedFromString += 2
            boldItalicCounter += 1
            
            let rangeOfLastCharacter = NSMakeRange(match.range.location + match.range.length - charactersRemovedFromString, 1)
            
            attributedString.replaceCharacters(in: rangeOfLastCharacter, with: "")
        }
        
        print("attributedString: \(attributedString)")
        
        return attributedString
    }
}
