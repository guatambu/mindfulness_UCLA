//
//  MeditationTimerViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit

class MeditationTimerViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var meditationTimerLabel: UILabel!
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var numericCountdownLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesChoiceSlider: UISlider!
    @IBOutlet weak var twoMinutesButtonOutlet: UIButton!
    @IBOutlet weak var fiveMinutesButtonOutlet: UIButton!
    @IBOutlet weak var tenMinutesButtonOutlet: UIButton!
    @IBOutlet weak var closeButtonOutlet: UIButton!
    
    
    // MARK: ViewControllers Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func twoMinutesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func fiveMinutesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func tenMinutesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MeditationTimerViewController {
    
    // MARK: UISlider Setup
    
    
}

extension MeditationTimerViewController {
    
    // MARK: Helper Functions
    
    func setTimer(countdown minutes: Int) {
        
    }
}
