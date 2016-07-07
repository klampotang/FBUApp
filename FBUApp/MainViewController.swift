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
    
    
    var cards: [PFObject]?
    var saved: [PFObject] = []
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var centerXFactor: CGFloat = 2.0
    var centerYFactor: CGFloat = 2.5
    var frameXFactor: CGFloat = 10
    var frameYFactor: CGFloat = 10
    
    var currentMainView: MainView!
    var mainViews: [MainView] = []
    
    
    @IBAction func onX(sender: AnyObject) {
        self.determineJudgement(.Left)
    }
    
    @IBAction func onLove(sender: AnyObject) {
        self.determineJudgement(.Right)
    }
    
    @IBAction func onSave(sender: AnyObject) {
        self.determineJudgement(.Down)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCards()
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
            }
            else {
                print("cards")
                //self.cards = []
                self.cards = cards!
                //self.isMoreDataLoading = false
                //MBProgressHUD.hideHUDForView(self.view, animated: true)
                //refresh.endRefreshing()
                
                for card in cards! {
                    self.currentMainView = MainView(
                        frame: CGRectMake(0, 0, self.view.frame.width - self.frameXFactor, self.view.frame.width - self.frameYFactor),
                        center: CGPoint(x: self.view.bounds.width / self.centerXFactor, y: self.view.bounds.height / self.centerYFactor),
                        card: card)
                    self.mainViews.append(self.currentMainView)
                    //print("first mainviews count \(self.mainViews.count)")
                    self.view.addSubview(self.currentMainView)
                    self.likeLabel.text = String(card["likesCount"])
                    self.distanceLabel.text = String(card["location"])
                    
                }
                /*
                for mainView in self.mainViews {
                    self.view.addSubview(mainView)
                }*/
                
                let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
                self.view.addGestureRecognizer(pan)
                //print("mainviews count \(self.mainViews.count)")
                
            }
        }

    }
    
    
    func determineJudgement(swipe: Swipe) {
        // Run the swipe animation
        self.currentMainView.swipe(swipe)
        
        if swipe == .Down {
            //saved.append(self.currentMainView.currentCard)
            let user = PFUser.currentUser()
            if let userSaved = user!["saved"] as? [PFObject] {
                print("user saved \(userSaved.count)")
                var savedCards = userSaved
                savedCards.append(self.currentMainView.currentCard)
                user!["saved"] = savedCards
                user?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if success {
                        print("saved")
                    }
                    else {
                        print("not saved")
                    }
                })
            }
            else {
                print("no saved")
            }
            
            
        }
        
        else if swipe == .Right {

            let currentCard = self.currentMainView.currentCard
            currentCard.fetchIfNeededInBackgroundWithBlock({ (currentCard: PFObject?, error: NSError?) in
                if error != nil {
                    print(error)
                }
                else {
                    var likes = currentCard!["likesCount"] as! Int
                    likes += 1
                    currentCard!["likesCount"] = likes
                    currentCard?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                        if success {
                            print("likes count incremented")
                        }
                        else {
                            print(error)
                        }
                    })
                }
            })
        }
        print("saved count \(self.saved.count)")
        
        // Handle when we have no more matches
        self.mainViews.removeAtIndex(self.mainViews.count - 1)
        
        if self.mainViews.count - 1 < 0 {
            let noMoreView = MainView(
                frame: CGRectMake(0, 0, self.view.frame.width - frameXFactor, self.view.frame.width - frameYFactor),
                center: CGPoint(x: self.view.bounds.width / centerXFactor, y: self.view.bounds.height / centerYFactor),
                card: PFObject()
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
            //let location = gesture.locationInView(self.view)
            if self.currentMainView.center.x / self.view.bounds.maxX > 0.6 {
                self.determineJudgement(.Right)
                
            }
            else if self.currentMainView.center.x / self.view.bounds.maxX < 0.4 {
                self.determineJudgement(.Left)
                
            }
            else if self.currentMainView.center.y / self.view.bounds.maxY > 0.5 {
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
