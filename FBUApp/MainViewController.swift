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
import Parse
import ParseUI
/*
enum Swipe {
    case Left
    case Right
    case Up
    case Down
}*/

class MainViewController: UIViewController {
    var images: [UIImage] = [UIImage(named: "demo1")!, UIImage(named: "demo2")!, UIImage(named: "demo3")!, UIImage(named: "demo4")!, UIImage(named: "demo5")!, UIImage(named: "demo6")!, UIImage(named: "demo7")!, UIImage(named: "demo8")!]
    
    @IBOutlet weak var pictureView: PFImageView!
    var cards: [PFObject] = []
    var saved: [PFObject] = []
    
    var centerXFactor: CGFloat = 2.0
    var centerYFactor: CGFloat = 2.5
    var frameXFactor: CGFloat = 10
    var frameYFactor: CGFloat = 10
    
    var currentMainView: MainView!
    var mainViews: [MainView] = []
    
    @IBAction func onX(sender: AnyObject) {
    }
    
    @IBAction func onLove(sender: AnyObject) {
    }
    
    @IBAction func onSave(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        loadCards()
        
        for card in cards {
            let imageFile = card["media"] as! PFFile
            currentMainView = MainView(
                frame: CGRectMake(0, 0, self.view.frame.width - frameXFactor, self.view.frame.width - frameYFactor),
                center: CGPoint(x: self.view.bounds.width / centerXFactor, y: self.view.bounds.height / centerYFactor),
                file: imageFile)
            self.mainViews.append(currentMainView)
        }
        
        for mainView in mainViews {
            self.view.addSubview(mainView)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    func loadCards() {
        let query = PFQuery(className: "Card")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        /*
        if firstLoad {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }*/
        query.findObjectsInBackgroundWithBlock { (cards: [PFObject]?, error: NSError?) in
            if error != nil {
                print(error)
                print("did not successfully get pics")
            }
            else {
                self.cards = cards!
                //self.isMoreDataLoading = false
                //MBProgressHUD.hideHUDForView(self.view, animated: true)
                //refresh.endRefreshing()
                
            }
        }

    }
    
    
    func determineJudgement(swipe: Swipe) {
        // Run the swipe animation
        self.currentMainView.swipe(swipe)
        
        // Handle when we have no more matches
        self.mainViews.removeAtIndex(self.mainViews.count - 1)
        /*
        if self.mainViews.count - 1 < 0 {
            let noMoreView = MainView(
                frame: CGRectMake(0, 0, self.view.frame.width - frameXFactor, self.view.frame.width - frameYFactor),
                center: CGPoint(x: self.view.bounds.width / centerXFactor, y: self.view.bounds.height / centerYFactor),
                file: nil
            )
            self.mainViews.append(noMoreView)
            self.view.addSubview(noMoreView)
            //self.done = true
            return
        }*/
        
        // Set the new current question to the next one
        self.currentMainView = self.mainViews.last!
        
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        // Is this gesture state finished??
        if gesture.state == UIGestureRecognizerState.Ended {
            // Determine if we need to swipe off or return to center
            let location = gesture.locationInView(self.view)
            if self.currentMainView.center.x / self.view.bounds.maxX > 0.6 {
                print("swipe right")
                self.determineJudgement(.Right)
                
            }
            else if self.currentMainView.center.x / self.view.bounds.maxX < 0.4 {
                print("swipe left")
                self.determineJudgement(.Left)
                
            }
            else if self.currentMainView.center.y / self.view.bounds.maxY > 0.5 {
                print("swipe down")
                self.determineJudgement(.Down)
                
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
