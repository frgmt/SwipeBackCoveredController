//
//  SecondController.swift
//  SwipeBackCoveredController
//
//  Created by naohide_a on 2015/10/27.
//  Copyright © 2015年 keepitreal. All rights reserved.
//

import UIKit

class SecondController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupNavigationBar()
        self.setupImageView()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.navigationController!.navigationBar.setBackgroundImage( UIImage() , forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        let title = UILabel()
        title.font = UIFont.boldSystemFontOfSize(16.0)
        title.textColor = UIColor.whiteColor()
        title.text = "Chicken"
        title.sizeToFit()
        self.navigationItem.titleView = title
        
        let backGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "goBack")
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "back")
        backImageView.frame = CGRectMake(0, 12, 10, 17)
        let backButton:UIButton = UIButton(type: UIButtonType.Custom)
        backButton.frame = CGRectMake(0, 0, 40, 40)
        backButton.addSubview(backImageView)
        backButton.addGestureRecognizer(backGestureRecognizer)
        let backItem: UIBarButtonItem = UIBarButtonItem()
        backItem.customView = backButton
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func setupImageView() {
        let image = UIImage(named: "chicken")
        let imageView = UIImageView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) * image!.size.height / image!.size.width))
        imageView.center.y = CGRectGetHeight(self.view.frame) / 2
        imageView.image = image
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "goBack"))
        self.view.addSubview(imageView)
    }
    
    // MARK: - UIGestureRecognizer
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
