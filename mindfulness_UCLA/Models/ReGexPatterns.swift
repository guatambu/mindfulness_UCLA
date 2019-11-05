//
//  RegExPatterns.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/21/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

enum RegExPatterns: String {
    
    case boldPattern = "(\\*(.*?)\\*)"
    case italicPattern = "(#(.*?)#)"
    case boldItalicPattern = "(\\$(.*?)\\$)"
    case smallItalicPattern = "(~(.*?)~)"
}
