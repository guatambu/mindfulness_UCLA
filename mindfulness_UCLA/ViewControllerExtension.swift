//
//  ViewControllerExtension.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/8/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func returnToDashboard() {
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            
            if viewController is DashboardTableViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                
            }
        }
    }
}
