//
//  MainView.swift
//  FBUApp
//
//  Created by Angeline Rao on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

enum Swipe {
    case Left
    case Right
    case Up
    case Down
}

class MainView: UIView {
    let imageMarginSpace: CGFloat = 3.0
    var pictureView: UIImageView!
    var originalCenter: CGPoint!
    var animator: UIDynamicAnimator!
    
    init(frame: CGRect, center: CGPoint, image: UIImage) {
        self.pictureView = UIImageView()
        self.pictureView.image = image
        super.init(frame: frame)
        self.center = center
        self.originalCenter = center
        animator = UIDynamicAnimator(referenceView: self)
        
        self.pictureView.frame = CGRectIntegral(CGRectMake(
            0.0 + self.imageMarginSpace,
            0.0 + self.imageMarginSpace,
            self.frame.width - (2 * self.imageMarginSpace),
            self.frame.height - (2 * self.imageMarginSpace)
            ))
        
    self.addSubview(pictureView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func swipe(swipe: Swipe) {
        animator.removeAllBehaviors()
        
        // If the answer is false, Move to the left
        // Else if the answer is true, move to the right
        var gravityX = 0.0
        var gravityY = 0.0
        if swipe == Swipe.Left {
            gravityX = -0.5
        }
        else if swipe == Swipe.Right {
            gravityX = 0.5
        }
        else if swipe == Swipe.Down {
            gravityY = 0.5
        }
        
        //let gravityX = answer ? 0.5 : -0.5
        var magnitude = 0.0
        if swipe == Swipe.Left {
            magnitude = -20.0
        }
        else if swipe == Swipe.Right {
            magnitude = 20.0
        }
        else if swipe == Swipe.Down {
            magnitude = 20.0
        }
        //let magnitude = answer ? 20.0 : -20.0
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [self])
        print(swipe)
        print(gravityX)
        print(gravityY)
        gravityBehavior.gravityDirection = CGVectorMake(CGFloat(gravityX), CGFloat(gravityY))
        animator.addBehavior(gravityBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [self], mode: UIPushBehaviorMode.Instantaneous)
        if swipe == Swipe.Down {
            pushBehavior.setAngle(CGFloat(M_PI_2), magnitude: CGFloat(magnitude))
        }
        pushBehavior.magnitude = CGFloat(magnitude)
        animator.addBehavior(pushBehavior)
        
    }
    
    func returnToCenter() {
        UIView.animateWithDuration(0.8, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .AllowUserInteraction, animations: {
            self.center = self.originalCenter
            }, completion: { finished in
                print("Finished Animation")}
        )
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
