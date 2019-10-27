//
//  Protocols.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/24/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

protocol CourseContentDetailsTableViewCellDelegate {
    
    // MARK: - Properties
//    var isLinkActive: Bool? { get set }
    
    // MARK: functions
    func openWebViewButtonTapped(cell: CourseContentDetailTableViewCell)
}
