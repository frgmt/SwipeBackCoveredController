//
//  FirstController.swift
//  SwipeBackCoveredController
//
//  Created by naohide_a on 2015/10/27.
//  Copyright © 2015年 keepitreal. All rights reserved.
//

import UIKit

class FirstController: UIViewController, UINavigationControllerDelegate {
    
    let customInteractionController = CustomInteractionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupNavigationBar()
        self.setupImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.navigationController!.delegate = self
        self.navigationController!.navigationBar.setBackgroundImage( UIImage() , forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        let title = UILabel()
        title.font = UIFont.boldSystemFontOfSize(16.0)
        title.text = "Chick"
        title.sizeToFit()
        self.navigationItem.titleView = title;
    }
    
    func setupImageView() {
        let image = UIImage(named: "chick")
        let imageView = UIImageView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) * image!.size.height / image!.size.width))
        imageView.center.y = CGRectGetHeight(self.view.frame) / 2
        imageView.image = image
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTapGesture:"))
        self.view.addSubview(imageView)
    }
    
    // Mark - UIGestureRecognizer

    func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SecondController") as! SecondController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Mark - UINavigationControllerDelegate
    
    func navigationController(
        navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            let customNavigationAnimationController = CustomNavigationAnimationController()
            if operation == .Push {
                customInteractionController.attachToViewController(toVC)
                customNavigationAnimationController.presenting = true
            } else {
                customNavigationAnimationController.presenting = false
            }
            return customNavigationAnimationController
    }
    
    func navigationController(navigationController: UINavigationController,
        interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
}