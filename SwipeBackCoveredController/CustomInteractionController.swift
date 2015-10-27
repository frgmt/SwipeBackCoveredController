//
//  CustomInteractionController.swift
//  SwipeBackCoveredController
//
//  Created by naohide_a on 2015/10/27.
//  Copyright © 2015年 keepitreal. All rights reserved.
//

import UIKit

class CustomInteractionController: UIPercentDrivenInteractiveTransition {
    var navigationController: UINavigationController!
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var completionSeed: CGFloat {
        return 1 - percentComplete
    }
    
    func attachToViewController(viewController: UIViewController) {
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
    
    private func setupGestureRecognizer(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanGesture:"))
    }
    
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        let viewTranslation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state {
        case .Began:
            if viewTranslation.x < 0 { return }
            transitionInProgress = true
            navigationController.popViewControllerAnimated(true)
        case .Changed:
            let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 340.0), 0.0), 1.0))
            shouldCompleteTransition = const > 0.5
            updateInteractiveTransition(const)
        case .Cancelled, .Ended:
            transitionInProgress = false
            if !shouldCompleteTransition || gestureRecognizer.state == .Cancelled {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
        default:
            print("Swift switch must be exhaustive, thus the default")
        }
    }
}