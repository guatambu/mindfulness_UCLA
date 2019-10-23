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
        
//        // create normal body font attribute
//        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let fontDescriptor = UIFontDescriptor.init(name: "GillSans", size: 16)
        let normalFont = UIFont(descriptor: fontDescriptor, size: 16)
        let normalAttributes = [NSAttributedString.Key.font: normalFont]
        
        // create bold typeface font attribute
        let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 16)
        let boldAttributes = [NSAttributedString.Key.font: boldFont]
        
        // create italic typeface font attribute
        let italicFontDescriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitItalic)
        let italicFont = UIFont(descriptor: italicFontDescriptor!, size: 16)
        let italicAttributes = [NSAttributedString.Key.font: italicFont]
        
        // create bold italics typeface font attributes
        let boldItalicFontDescriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(arrayLiteral: .traitBold, .traitItalic))
        let boldItalicFont = UIFont(descriptor: boldItalicFontDescriptor!, size: 16)
        let boldItalicAttributes = [NSAttributedString.Key.font: boldItalicFont]
        
        // create small italics typeface font attributes
        let smallItalicFontDescriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(arrayLiteral: .traitItalic))
        let smallItalicFont = UIFont(descriptor: smallItalicFontDescriptor!, size: 12)
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
            
//            if i == 0 {
//
//                charactersRemovedFromString = 0
//            }
            
            let newRange = NSMakeRange(match.range.location - charactersRemovedFromString, match.range.length)
            
            attributedString.addAttributes(normalAttributes, range:newRange)
            
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



//        for (pattern, attributes) in replacements {
//
//            let regex = try! NSRegularExpression(pattern: pattern)
//
//            regex.enumerateMatches(in: stringToFormat, range: searchRange) {
//                match, flags, stop in
//
//                if let matchRange = match?.range(at: 1) {
//
//                    print("Matched pattern: \(pattern)")
//
//                    let newRange = NSMakeRange(matchRange.location - numberOfCharactersRemovedFromStringToFormat, matchRange.length)
//
//                    attributedString.addAttributes(attributes, range: newRange)
//
////                    let maxRange = matchRange.location + matchRange.length
////
////                    if maxRange + 1 < attributedString.length {
////                        attributedString.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
////                    }
//
//                    let rangeOfFirstCharacterToRemove = NSRange(location: matchRange.location - numberOfCharactersRemovedFromStringToFormat, length: 1)
//
//                    attributedString.replaceCharacters(in: rangeOfFirstCharacterToRemove, with: "")
//
//
//                    numberOfCharactersRemovedFromStringToFormat += 2
//
//                    let rangeOfLastCharacterToRemove = NSRange(location: matchRange.location + matchRange.length - numberOfCharactersRemovedFromStringToFormat, length: 1)
//
//                    attributedString.replaceCharacters(in: rangeOfLastCharacterToRemove, with: "")
//                }
//            }
//        }


