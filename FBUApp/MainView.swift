//
//  MainView.swift
//  FBUApp
//
//  Created by Angeline Rao on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

class MainView: UIView {
    let imageMarginSpace: CGFloat = 3.0
    var pictureView: UIImageView!
    var originalCenter: CGPoint!
    var animator: UIDynamicAnimator!
    
    init(frame: CGRect, center: CGPoint, image: UIImage) {
        self.pictureView.image = image
        super.init(frame: frame)
        self.center = center
        self.originalCenter = center
        self.pictureView.frame = CGRectIntegral(CGRectMake(
            0.0 + self.imageMarginSpace,
            0.0 + self.imageMarginSpace,
            self.frame.width - (2 * self.imageMarginSpace),
            self.frame.height - (2 * self.imageMarginSpace)
            ))
        
    self.addSubview(pictureView)

    }
    
    func swipe(answer: Bool) {
        animator.removeAllBehaviors()
        
        // If the answer is false, Move to the left
        // Else if the answer is true, move to the right
        let gravityX = answer ? 0.5 : -0.5
        let magnitude = answer ? 20.0 : -20.0
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [self])
        gravityBehavior.gravityDirection = CGVectorMake(CGFloat(gravityX), 0)
        animator.addBehavior(gravityBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [self], mode: UIPushBehaviorMode.Instantaneous)
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
