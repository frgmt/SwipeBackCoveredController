//
//  CustomNavigationAnimationController.swift
//  SwipeBackCoveredController
//
//  Created by naohide_a on 2015/10/27.
//  Copyright © 2015年 keepitreal. All rights reserved.
//

import UIKit

class CustomNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    internal var presenting = true
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let containerSize = containerView!.frame.size
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView = toViewController.view
        let fromView = fromViewController.view
        let offScreenRight = CGAffineTransformMakeTranslation(containerSize.width, 0)
        let duration = self.transitionDuration(transitionContext)

        if self.presenting {
            toView.center.x += containerSize.width
            containerView?.addSubview(toView)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.frame = CGRectMake(-80.0, transitionContext.initialFrameForViewController(toViewController).origin.y, containerSize.width, containerSize.height)
                toView.transform = CGAffineTransformIdentity
                toView.frame = CGRectMake(0, transitionContext.finalFrameForViewController(toViewController).origin.y, containerSize.width, containerSize.height)
                }, completion: {
                    finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        } else {
            toView.frame = CGRectMake(-80.0, transitionContext.finalFrameForViewController(toViewController).origin.y, containerSize.width, containerSize.height)
            containerView?.insertSubview(toView, belowSubview: fromView)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.transform = offScreenRight
                fromViewController.navigationItem.titleView!.transform = offScreenRight
                fromViewController.navigationItem.leftBarButtonItem?.customView!.transform = offScreenRight
                fromViewController.navigationItem.rightBarButtonItem?.customView!.transform = offScreenRight
                toView.transform = CGAffineTransformIdentity
                toView.frame = CGRectMake(0, transitionContext.finalFrameForViewController(toViewController).origin.y, containerSize.width, containerSize.height)
                }, completion: {
                    finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
}
