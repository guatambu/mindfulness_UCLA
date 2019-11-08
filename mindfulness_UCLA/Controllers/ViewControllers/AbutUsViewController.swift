//
//  AbutUsViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/6/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class AbutUsViewController: UIViewController, SFSafariViewControllerDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    // MARK: - Properties
    
    
    //MARK: ViewController Lifecycle Funcitons

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions


    @IBAction func websiteButtonTapped(_ sender: UIButton) {
        
        openWebsite()
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
        composeEmail()
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        placePhoneCallOrText()
    }
    
    @IBAction func adminCheckButtonTapped(_ sender: UIButton) {
        
        // programmatically performing the segue
        
        // instantiate the relevant storyboard
        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate the desired TableViewController as ViewController on relevant storyboard
        let destViewController = mainView.instantiateViewController(withIdentifier: "toAdminCheck") as! AdminCheckTableViewController
        // create the segue programmatically - PUSH
        self.navigationController?.pushViewController(destViewController, animated: true)
        // set the desired properties of the destinationVC's navgation Item
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = " "
        navigationItem.backBarButtonItem = backButtonItem
    }
}


// MARK: - Helper Funcitons
extension AbutUsViewController {
    
    func openWebsite() {
        
        let urlString = AboutUsLinks.websiteURL.rawValue
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
    }
    
    func composeEmail() {
        
        // bring up a Mail compose viewcontroller
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // set the "To:" recipients email
        composeVC.setToRecipients([AboutUsLinks.email.rawValue])
        // Present the view controller modally.
        if MFMailComposeViewController.canSendMail() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("User does not allow or has not set up to send email messages.")
        }
//        if let url = URL(string: "mailto:\(AboutUsLinks.email.rawValue)") {
//
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
    }
    
    func placePhoneCallOrText() {
        // alertCpntroller to present the contact options
        let alert = UIAlertController(title: "Contact Us", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        // cancel action to dismiss the action sheet
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.destructive, handler: nil)
        
        // call action to places a call to the provided phone number
        let call = UIAlertAction(title: "call", style: UIAlertAction.Style.default) { (action) in
            
            if let url = URL(string: "tel://\(AboutUsLinks.phone.rawValue)") {
                
                if UIApplication.shared.canOpenURL(url) {
                    
                    UIApplication.shared.open(url)
                }
            }
        }
        
        // text action to bring up a Messages Compose ViewController
        let text = UIAlertAction(title: "text", style: UIAlertAction.Style.default) { (action) in
            
            // bring up a Messages compose viewcontroller
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            // set the recipient phone number
            composeVC.recipients = [AboutUsLinks.phone.rawValue]
            // Present the view controller modally.
            if MFMessageComposeViewController.canSendText() {
                self.present(composeVC, animated: true, completion: nil)
            } else {
                print("User does not allow or has not set up to send text messages.")
            }
//            if let url = URL(string: "sms://\(AboutUsLinks.phone.rawValue)") {
//
//                if UIApplication.shared.canOpenURL(url) {
//
//                    UIApplication.shared.open(url)
//                }
//            }
        }
        
        alert.addAction(call)
        alert.addAction(text)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    // MARK: - MessageUI protocol funcitons
    
    // Messages
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MAil
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        dismiss(animated: true, completion: nil)
    }
}



