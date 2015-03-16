//
//  DetailViewController.swift
//  Animation
//
//  Created by LOANER on 3/15/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var sharkIcon:UIImageView?
    var surfIcon:UIImageView?
    var sharkLabel:UILabel?
    var surfLabel:UILabel?
    var bottomLine:UIView?
    var seperator:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createSharkIcon()
        createSharkLabel()
        createBottomLine()
        createSeperator()
        createSurfIcon()
        createSurfLabel()
    }
    
    func createSharkIcon() {
        self.sharkIcon = UIImageView(image: UIImage(named: "shark"))
        self.sharkIcon?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.sharkIcon!)
        
        self.sharkIcon?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.left.equalTo(30)
            make.centerY.equalTo(self.view.snp_centerY)
        })
    }
    
    func createSharkLabel() {
        self.sharkLabel = UILabel(frame: CGRectZero)
        self.sharkLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.sharkLabel?.text = "SMALL CHANCE"
        self.sharkLabel?.numberOfLines = 0
        self.sharkLabel?.font = UIFont(name: "DINCondensed-Bold", size: 18)
        self.sharkLabel?.textColor = UIColor.whiteColor()
        self.view.addSubview(self.sharkLabel!)
        
        self.sharkLabel?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(80)
            make.left.equalTo(self.sharkIcon!.snp_right).with.offset(20)
            make.centerY.equalTo(self.view.snp_centerY).with.offset(2)
        })
    }
    
    func createSurfIcon() {
        self.surfIcon = UIImageView(image: UIImage(named: "surf"))
        self.surfIcon?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.surfIcon!)
        
        self.surfIcon?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.left.equalTo(self.seperator!.snp_right).with.offset(30)
            make.centerY.equalTo(self.view.snp_centerY)
        })
    }
    
    func createSurfLabel() {
        self.surfLabel = UILabel(frame: CGRectZero)
        self.surfLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.surfLabel?.text = "1.138.201 SURFERS/YEAR"
        self.surfLabel?.numberOfLines = 0
        self.surfLabel?.font = UIFont(name: "DINCondensed-Bold", size: 18)
        self.surfLabel?.textColor = UIColor.whiteColor()
        self.view.addSubview(self.surfLabel!)
        
        self.surfLabel?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(100)
            make.left.equalTo(self.surfIcon!.snp_right).with.offset(20)
            make.centerY.equalTo(self.view.snp_centerY).with.offset(2)
        })
    }
    
    func createBottomLine() {
        self.bottomLine = UIView(frame: CGRectZero)
        self.bottomLine?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomLine?.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        self.view.addSubview(self.bottomLine!)
        
        self.bottomLine?.snp_makeConstraints({ (make) -> () in
            make.height.equalTo(1)
            make.width.equalTo(self.view.snp_width)
            make.left.equalTo(0)
            make.bottom.equalTo(self.view.snp_bottom)
        })
    }
    
    func createSeperator() {
        self.seperator = UIView(frame: CGRectZero)
        self.seperator?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.seperator?.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        self.view.addSubview(self.seperator!)
        
        self.seperator?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(1)
            make.height.equalTo(self.view.snp_height)
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(0)
        })
    }

}
