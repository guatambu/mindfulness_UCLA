//
//  DashboardTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michel Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // tableView's static cells
    @IBOutlet weak var gettingStartedCell: UITableViewCell!
    @IBOutlet weak var courseContentCell: UITableViewCell!
    @IBOutlet weak var guidedMeditationsCell: UITableViewCell!
    @IBOutlet weak var videoCoursesCell: UITableViewCell!
    
    // static cells general content views
    @IBOutlet weak var gettingStartedContentView: UIView!
    @IBOutlet weak var courseContentContentView: UIView!
    @IBOutlet weak var guidedMeditaitonsContentView: UIView!
    @IBOutlet weak var videoClassesContentView: UIView!
    // static cell image container views
    @IBOutlet weak var gettingStartedView: UIView!
    @IBOutlet weak var courseContentView: UIView!
    @IBOutlet weak var guidedMeditationsView: UIView!
    @IBOutlet weak var videoClassesView: UIView!
    
    
    // MRAK: - ViewController Lifecycle funcitons

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup navBar dimensions
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 1242, height: 44)
        
        // round corners on each static cell's view
        gettingStartedView.layer.cornerRadius = 10
        courseContentView.layer.cornerRadius = 10
        guidedMeditationsView.layer.cornerRadius = 10
        videoClassesView.layer.cornerRadius = 10
        // configure static cells' content views
        gettingStartedContentView.backgroundColor = UIColor.clear
        courseContentContentView.backgroundColor = UIColor.clear
        guidedMeditaitonsContentView.backgroundColor = UIColor.clear
        videoClassesContentView.backgroundColor = UIColor.clear
        // set individual static cell's background colors
        gettingStartedCell.backgroundColor = UIColor.clear
        courseContentCell.backgroundColor = UIColor.clear
        guidedMeditationsCell.backgroundColor = UIColor.clear
        videoCoursesCell.backgroundColor = UIColor.clear
        
        // screen width and height:
        let width = ((UIScreen.main.bounds.size.width) - 120)
        let height = ((UIScreen.main.bounds.size.height) - 120)
        let centerX = ((UIScreen.main.bounds.size.width)/2)
        
        // add the tableView's background view's image view
        let tableBackgroundSubView = UIView()
        let backgroundImage = UIImage(named: "UCLA_Meditation_Course_Lotus_Flower_Original_Image_Background_Blue.png")
        let backgroundImageView = UIImageView(frame: CGRect(x: (centerX - (width/2)), y: 0, width: width, height: height))
        backgroundImageView.image = backgroundImage
        // set the content mode:
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFit
        // add the image view as subView
        tableBackgroundSubView.addSubview(backgroundImageView)
        // set tableView background to desired view
        self.tableView.backgroundView = tableBackgroundSubView
    }
}
