//
//  VideosAndReadingsViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/8/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class VideosAndReadingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the desired properties of the destinationVC's navgation Item
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(self.returnToDashboard))
        navigationItem.rightBarButtonItem = closeItem
    }
    


}
