//
//  ViewController.swift
//  cointoss
//
//  Created by Jake Dahn on 8/22/14.
//  Copyright (c) 2014 Jake Dahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!

    var tossBtnView: UIView!
//    var back: UIImageView!
    var front: UIImageView!
    var showingBack = false

    func toss(){

        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: {
            self.tossBtnView.alpha = 0.5
        }, completion: nil)

        
        var headsList: [Int] = []
        var tailsList: [Int] = []
        
        for i in 1...100000 {
            if arc4random_uniform(2) == 0 {
                headsList.append(1)
            } else {
                tailsList.append(1)
            }
        }
        
        if headsList.count > tailsList.count {
            self.resultLabel.text = "Heads"
        }
        if headsList.count < tailsList.count {
            self.resultLabel.text = "Tails"
        }
        if headsList.count == tailsList.count {
            self.resultLabel.text = "Tie"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height


        let headsImg = UIImage(named: "tossbtn")
//        let tailsImg = UIImage(named: "tossbtn-tails")

        let front = UIImageView(image: headsImg)
//        let back = UIImageView(image: tailsImg)
        
        let rect = CGRectMake(CGFloat(screenWidth * 0.5 - headsImg.size.width/2), CGFloat(screenHeight * 0.7), headsImg.size.width, headsImg.size.height)

        let singleTap = UITapGestureRecognizer(target: self, action: Selector("toss"))
        singleTap.numberOfTapsRequired = 1

        tossBtnView = UIView(frame: rect)
        tossBtnView.addGestureRecognizer(singleTap)
//        tossBtnView.addSubview(back)
        tossBtnView.addSubview(front)
        view.addSubview(tossBtnView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

