//
//  VideoCoursesTableViewCell.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/27/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class VideoCoursesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var videoCourseThumbnailIMageView: UIImageView!
    @IBOutlet weak var videoCourseTitleLabel: UILabel!
    @IBOutlet weak var openSafariWebViewButton: UIButton!
    
    var delegate: VideoCourseTableViewCellDelegate?
    
    var videoCourse: GuidedMeditation? {
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
        
        guard let videoCourse = videoCourse else {
            
            print("ERROR: nil value found for videoCourse object in VideoCoursesTableViewCell.swift - updateViews() - line 36.")
            return
        }
        
        videoCourseThumbnailIMageView.image = UIImage(named: "\(videoCourse.path)")
        videoCourseTitleLabel.text = videoCourse.title
        videoCourseThumbnailIMageView.image = UIImage(named: videoCourse.thumbnailPath)
    }
    
    
    // MARK: - openSafariWebViewButtonTapped
    
    @IBAction func openSafariWebViewButtonTapped(_ sender: UIButton) {
        
        delegate?.openWebViewButtonTapped(cell: self)
    }
}
