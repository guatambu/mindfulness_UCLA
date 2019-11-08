//
//  OnlineStudentCommunityViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/8/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices

class OnlineStudentCommunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Actions
 
    @IBAction func onlineCommunityButtonTapped(_ sender: UIButton) {
        
        let urlString = GettingStartedHyperLinkStrings.palouseMindfulnessOnlineStudentCommunityURL.rawValue
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
    }
    
}


extension OnlineStudentCommunityViewController: SFSafariViewControllerDelegate {
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
