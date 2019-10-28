//
//  Protocols.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/24/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

protocol CourseContentDetailsTableViewCellDelegate {
    
    // TODO: update this protocol to include capacity to work with PDFKit, and add protocol method(s) to this protocol that will allow for the viewing and manipulation of the PDF file
    
    // MARK: - Properties
    
    // MARK: functions
    func openWebViewButtonTapped(cell: CourseContentDetailTableViewCell)
}

protocol VideoCourseTableViewCellDelegate {
    
    // MARK: - Properties
    
    // MARK: functions
    func openWebViewButtonTapped(cell: VideoCoursesTableViewCell)
}
