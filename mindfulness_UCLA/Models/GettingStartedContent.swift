//
//  GettingStartedContent.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/6/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

class GettingStartedContent {
    
    // MARK: Properties
    
    // week's lesson title properties
    var title: String
    var subTitle: String?
    /* these are all of type Tuple of Strings */
    // the .0 being a heading/title, and the .1 being the body text of the paragraph
    var textParagraph1: (String, String)
    var textParagraph2: (String, String)?
    var textParagraph3: (String, String)?
    var textParagraph4: (String, String)?
    var textParagraph5: (String, String)?
    var textParagraph6: (String, String)?
    var textParagraph7: (String, String)?
    var textParagraph8: (String, String)?
    var textParagraph9: (String, String)?
    // hyperlink text and corresponding URL String
    var hyperlink1: (String, String)
    var hyperlink2: (String, String)?
    var hyperlink3: (String, String)?
    var hyperlink4: (String, String)?
    var hyperlink5: (String, String)?
    var hyperlink6: (String, String)?
    var hyperlink7: (String, String)?
    var hyperlink8: (String, String)?
    var hyperlink9: (String, String)?
    
    // MARK: Initialization
    init(title: String,
         subTitle: String?,
         textParagraph1: (String, String),
         textParagraph2: (String, String)?,
         textParagraph3: (String, String)?,
         textParagraph4: (String, String)?,
         textParagraph5: (String, String)?,
         textParagraph6: (String, String)?,
         textParagraph7: (String, String)?,
         textParagraph8: (String, String)?,
         textParagraph9: (String, String)?,
         hyperlink1: (String, String),
         hyperlink2: (String, String)?,
         hyperlink3: (String, String)?,
         hyperlink4: (String, String)?,
         hyperlink5: (String, String)?,
         hyperlink6: (String, String)?,
         hyperlink7: (String, String)?,
         hyperlink8: (String, String)?,
         hyperlink9: (String, String)?
        ) {
        
        self.title = title
        self.subTitle = subTitle
        self.textParagraph1 = textParagraph1
        self.textParagraph2 = textParagraph2
        self.textParagraph3 = textParagraph3
        self.textParagraph4 = textParagraph4
        self.textParagraph5 = textParagraph5
        self.textParagraph6 = textParagraph6
        self.textParagraph7 = textParagraph7
        self.textParagraph8 = textParagraph8
        self.textParagraph9 = textParagraph9
        self.hyperlink1 = hyperlink1
        self.hyperlink2 = hyperlink2
        self.hyperlink3 = hyperlink3
        self.hyperlink4 = hyperlink4
        self.hyperlink5 = hyperlink5
        self.hyperlink6 = hyperlink6
        self.hyperlink7 = hyperlink7
        self.hyperlink8 = hyperlink8
        self.hyperlink9 = hyperlink9
    }
}

extension GettingStartedContent: Equatable {
    
    static func ==(lhs: GettingStartedContent, rhs: GettingStartedContent) -> Bool {
        if lhs.title != rhs.title { return false }
        if lhs.subTitle != rhs.subTitle { return false }
        if lhs.textParagraph1 != rhs.textParagraph1 { return false }
        if lhs.textParagraph2 ?? ("", "") != rhs.textParagraph2 ?? ("", "") { return false }
        if lhs.textParagraph3 ?? ("", "") != rhs.textParagraph3 ?? ("", "") { return false }
        if lhs.textParagraph4 ?? ("", "") != rhs.textParagraph4 ?? ("", "") { return false }
        if lhs.textParagraph5 ?? ("", "") != rhs.textParagraph5 ?? ("", "") { return false }
        if lhs.textParagraph6 ?? ("", "") != rhs.textParagraph6 ?? ("", "") { return false }
        if lhs.textParagraph7 ?? ("", "") != rhs.textParagraph7 ?? ("", "") { return false }
        if lhs.textParagraph8 ?? ("", "") != rhs.textParagraph8 ?? ("", "") { return false }
        if lhs.textParagraph9 ?? ("", "") != rhs.textParagraph9 ?? ("", "") { return false }
        if lhs.hyperlink1 != rhs.hyperlink1 { return false }
        if lhs.hyperlink2 ?? ("", "") != rhs.hyperlink2 ?? ("", "") { return false }
        if lhs.hyperlink3 ?? ("", "") != rhs.hyperlink3 ?? ("", "") { return false }
        if lhs.hyperlink4 ?? ("", "") != rhs.hyperlink4 ?? ("", "") { return false }
        if lhs.hyperlink5 ?? ("", "") != rhs.hyperlink5 ?? ("", "") { return false }
        if lhs.hyperlink6 ?? ("", "") != rhs.hyperlink6 ?? ("", "") { return false }
        if lhs.hyperlink7 ?? ("", "") != rhs.hyperlink7 ?? ("", "") { return false }
        if lhs.hyperlink8 ?? ("", "") != rhs.hyperlink8 ?? ("", "") { return false }
        if lhs.hyperlink9 ?? ("", "") != rhs.hyperlink9 ?? ("", "") { return false }
        
        return true
    }
}



