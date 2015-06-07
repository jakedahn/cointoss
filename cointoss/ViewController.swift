//
//  ViewController.swift
//  cointoss
//
//  Created by Jake Dahn on 8/22/14.
//  Copyright (c) 2014 Jake Dahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.alpha = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var tossBtn: UIButton!
    @IBOutlet weak var trialStatus: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var result: UILabel!
    
    
    @IBAction func tossHandler(sender: AnyObject) {
        self.activityIndicator.startAnimating()

        UIView.animateWithDuration(0.3,
            delay: 0,
            options: .CurveLinear & .AllowUserInteraction & .BeginFromCurrentState,
            animations: {
                self.tossBtn.alpha = 0
                self.activityIndicator.alpha = 1
            }, completion: nil)

        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT

        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.tossBtn.enabled = false
            let (tossResult, headsCount, tailsCount) = self.toss()
            sleep(1)

            dispatch_async(dispatch_get_main_queue()) {
                UIView.animateWithDuration(0.3,
                    delay: 0,
                    options: .CurveLinear & .AllowUserInteraction & .BeginFromCurrentState,
                    animations: {
                        self.tossBtn.alpha = 1
                        self.activityIndicator.alpha = 0
                    }, completion: nil)

                self.resultLabel.text = "\(headsCount) heads | \(tailsCount) tails"
                self.result.text = "\(tossResult)"
                self.tossBtn.enabled = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    func toss() -> (result: String, headsCount: Int, tailsCount: Int) {

        var headsList: [Int] = []
        var tailsList: [Int] = []
        var tossCount = 1000
        
        for i in 1...tossCount {
            if (arc4random_uniform(2) == 0) {
                headsList.append(1)
            } else {
                tailsList.append(1)
            }
        }

        var labeltext = ""
        if headsList.count > tailsList.count {
            labeltext = "Heads"
        }
        if headsList.count < tailsList.count {
           labeltext = "Tails"
        }
        if headsList.count == tailsList.count {
            labeltext = "Tie"
        }
        
        return (labeltext, headsList.count, tailsList.count)
    }
    

}

