//
//  VideoCoursesTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices

class VideoCoursesTableViewController: UITableViewController,
                                       VideoCourseTableViewCellDelegate,
                                       SFSafariViewControllerDelegate {
    
    // MARK: - Properties
    
    let videoCourses: [VideoCourse] = [ MindfulYoga1.metaData, MindfulYoga2.metaData ]
    
    
    // MARK: - ViewController Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "video courses"
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videoCourses.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCoursesCell", for: indexPath) as? VideoCoursesTableViewCell else {
            
            print("ERROR: nil value found for cell in VideoCourseTableViewController.swift - tableView(_ tableView: cellForRowAt:) - line 45.")
            
            return UITableViewCell()
        }

        // Configure the cell...
        cell.delegate = self
        
        let videoCourse = videoCourses[indexPath.row]
        
        cell.videoCourse = videoCourse

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: VideoCourseTableViewCellDelegate functions
    
    func openWebViewButtonTapped(cell: VideoCoursesTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            
            print("ERROR: nil value found for indexPath in VideoCoursesTableViewController.swift -> openWebViewButtonTapped(cell:) - line 66.")
            return
        }
        
        let urlString = videoCourses[indexPath.row].url
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            
            safariVC.delegate = self
            
            self.present(safariVC, animated: true)
        }
        
    }
    
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
