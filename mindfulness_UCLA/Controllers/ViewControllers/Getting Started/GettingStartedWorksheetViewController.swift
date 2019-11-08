//
//  GettingStartedWorksheetViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/8/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices

class GettingStartedWorksheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Actions

    @IBAction func pdfVersionButtonTapped(_ sender: UIButton) {
        
        let urlString = GettingStartedHyperLinkStrings.gettingStartedWorksheetPDFURL.rawValue
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
    }
    
    @IBAction func wordVersionButtonTapped(_ sender: UIButton) {
        
        let urlString = GettingStartedHyperLinkStrings.gettingStartedWorksheetWORDURL.rawValue
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
    }
}


extension GettingStartedWorksheetViewController: SFSafariViewControllerDelegate {
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
