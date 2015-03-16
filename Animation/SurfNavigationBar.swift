//
//  SurfNavigationBar.swift
//  Animation
//
//  Created by LOANER on 3/15/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit
import Snap

class SurfNavigationBar: UINavigationBar {
    var loader = UIView(frame: CGRectZero)
    var gradientLayer = CAGradientLayer()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setBackgroundImage(UIImage(named: "navbar"), forBarMetrics: UIBarMetrics.Default)
        
        // Title
        self.tintColor = UIColor.whiteColor()

        var attributes:[String:AnyObject] = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 18)!];
        self.titleTextAttributes = attributes
        
        // loader
        self.loader = UIView(frame:CGRectZero)
        self.loader.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.loader.backgroundColor = UIColor.greenColor()
        self.addSubview(self.loader)
        
        loader.snp_makeConstraints { (make) -> () in
            make.width.equalTo(self.snp_width)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, 2)
        self.gradientLayer.colors = [UIColor(red: 0.349, green: 0.584, blue: 0.906, alpha: 1.0).CGColor, UIColor(red: 0.992, green: 0.38, blue: 0.278, alpha: 1.0).CGColor]
        self.gradientLayer.startPoint = CGPointMake(0, 0.5)
        self.gradientLayer.endPoint = CGPointMake(1, 0.5)
        self.loader.layer.addSublayer(self.gradientLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, 2)
    }

}
