//
//  MainViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

// pls merge
// MERGE


import UIKit

class MainViewController: UIViewController {
    var images: [UIImage] = [UIImage(named: "demo1")!, UIImage(named: "demo2")!, UIImage(named: "demo3")!]
    var centerXFactor: CGFloat = 2.0
    var centerYFactor: CGFloat = 2.5
    var frameXFactor: CGFloat = 40
    var frameYFactor: CGFloat = 40
    
    var currentMainView: MainView!
    var mainViews: [MainView] = []
    var saved: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for image in images {
            currentMainView = MainView(
                frame: CGRectMake(100, 100, self.view.frame.width - frameXFactor, self.view.frame.width - frameYFactor),
                center: CGPoint(x: self.view.bounds.width / centerXFactor, y: self.view.bounds.height / centerYFactor),
                image: image)
            self.mainViews.append(currentMainView)
        }
        
        for mainView in mainViews {
            self.view.addSubview(mainView)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    
    func determineJudgement(answer: Bool) {
        // Run the swipe animation
        self.currentMainView.swipe(answer)
        
        // Handle when we have no more matches
        self.mainViews.removeAtIndex(self.mainViews.count - 1)
        if self.mainViews.count - 1 < 0 {
            let noMoreView = MainView(
                frame: CGRectMake(0, 0, self.view.frame.width - 50, self.view.frame.width - 50),
                center: CGPoint(x: self.view.bounds.width / centerXFactor, y: self.view.bounds.height / centerYFactor),
                image: UIImage()
            )
            self.mainViews.append(noMoreView)
            self.view.addSubview(noMoreView)
            //self.done = true
            return
        }
        
        // Set the new current question to the next one
        self.currentMainView = self.mainViews.last!
        
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        // Is this gesture state finished??
        if gesture.state == UIGestureRecognizerState.Ended {
            // Determine if we need to swipe off or return to center
            let location = gesture.locationInView(self.view)
            if self.currentMainView.center.x / self.view.bounds.maxX > 0.8 {
                self.determineJudgement(true)
            }
            else if self.currentMainView.center.x / self.view.bounds.maxX < 0.2 {
                self.determineJudgement(false)
            }
            else {
                self.currentMainView.returnToCenter()
            }
        }
        let translation = gesture.translationInView(self.currentMainView)
        self.currentMainView.center = CGPoint(x: self.currentMainView!.center.x + translation.x, y: self.currentMainView!.center.y + translation.y)
        gesture.setTranslation(CGPointZero, inView: self.view)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
