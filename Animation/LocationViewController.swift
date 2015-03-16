//
//  LocationViewController.swift
//  Animation
//
//  Created by LOANER on 3/14/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit
import Snap

class LocationViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            self.scrollView.contentSize = CGSizeMake(0, 950)
            self.scrollView.delegate = self
            self.scrollView.showsVerticalScrollIndicator = false
        }
    }
    var headerImage:UIImageView?
    var stateLabel:UILabel?
    var placeLabel:UILabel?
    var topWrapper:UIView?
    var detailVC:DetailViewController?
    var isInBackground:Bool = false
    var overlay:UIView?
    var location:Location? {
        didSet {
            update()
        }
    }
    
    var slideOut:UIView?
    var slideOutBottomConstraint:NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Right bar button item
        let fooItem = UIBarButtonItem(image: UIImage(named: "wave"), style: UIBarButtonItemStyle.Bordered, target: self, action: "foo:")
        self.navigationItem.rightBarButtonItem = fooItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.988, green: 0.38, blue: 0.278, alpha: 1)
        
        // Set a backgroundColor
        self.view.backgroundColor = UIColor(red: 0.184, green: 0.216, blue: 0.243, alpha: 1)
        
        self.topWrapper = UIView(frame: CGRectZero)
        self.topWrapper?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.topWrapper?.backgroundColor = UIColor.redColor()
        self.scrollView.addSubview(self.topWrapper!)
        
        self.topWrapper?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(self.scrollView.snp_width)
            make.height.equalTo(325)
            make.left.equalTo(0)
            make.top.equalTo(0)
        })
        
        createHeaderImage()
        
        self.detailVC = DetailViewController()
        self.scrollView.addSubview(self.detailVC!.view)
        
        self.detailVC!.view.snp_makeConstraints { (make) -> () in
            make.top.equalTo(self.headerImage!.snp_bottom)
            make.left.equalTo(0)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(70)
        }
        
        createDummyContent()
        createOverlay()
        
        createSlideOut()

        // Update on view did load because location is set before the view is loaded
        update()
    }

    func update() {
        self.placeLabel?.text = self.location?.place
        self.stateLabel?.text = self.location?.state
        self.headerImage?.image = UIImage(named: self.location!.image + "-color")
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView.contentOffset.y < -64) {
            let contentOffset = scrollView.contentOffset.y
            let diff = contentOffset + 64
        
            self.topWrapper?.snp_updateConstraints({ (make) -> () in
                make.top.equalTo(diff)
                make.height.equalTo(325 - diff)
            })
        }
    }
    
    
    func createHeaderImage() {
        // Image in it self
        self.headerImage = UIImageView(image: UIImage(named: "longbeach-color"))
        self.headerImage?.contentMode = UIViewContentMode.ScaleAspectFill   
        self.headerImage?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.topWrapper!.addSubview(self.headerImage!)
        
        self.headerImage?.snp_makeConstraints({ (make) -> () in
            make.bottom.equalTo(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.top.equalTo(0)
        })
        
        // LocationLabel
        self.placeLabel = UILabel(frame: CGRectZero)
        self.placeLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.placeLabel?.font = UIFont(name: "PlayfairDisplay-Bold", size: 35.0)
        self.placeLabel?.textColor = UIColor.whiteColor()
        self.placeLabel?.text = "FOOO"
        self.placeLabel?.layer.shadowColor = UIColor.blackColor().CGColor
        self.placeLabel?.layer.shadowRadius = 1.0
        self.placeLabel?.layer.shadowOffset = CGSizeMake(0, 1)
        self.placeLabel?.layer.shadowOpacity = 0.5
        self.topWrapper?.addSubview(self.placeLabel!)
        
        self.placeLabel?.snp_makeConstraints({ (make) -> () in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(59)
        })
        
        // StateLabel
        self.stateLabel = UILabel(frame:CGRectZero)
        self.stateLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.stateLabel?.font = UIFont(name: "AvenirNext-Regular", size: 17.0)
        self.stateLabel?.textColor = UIColor(red: 0.518, green: 1, blue: 0.816, alpha: 1)
        self.stateLabel?.layer.shadowColor = UIColor.blackColor().CGColor
        self.stateLabel?.layer.shadowRadius = 1.0
        self.stateLabel?.layer.shadowOffset = CGSizeMake(0, 1)
        self.stateLabel?.layer.shadowOpacity = 0.5
        self.topWrapper?.addSubview(self.stateLabel!)
        
        self.stateLabel?.snp_makeConstraints({ (make) -> () in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(self.placeLabel!.snp_bottom).with.offset(5)
        })
    }

    func createDummyContent() {
        let title = UILabel(frame: CGRectZero)
        title.setTranslatesAutoresizingMaskIntoConstraints(false)
        title.font = UIFont(name: "PlayfairDisplay-Bold", size: 30.0)
        title.text = "The Spot"
        title.textColor = UIColor(red: 0.518, green: 1, blue: 0.816, alpha: 1)
        self.scrollView.addSubview(title)
        
        title.snp_makeConstraints { (make) -> () in
            make.top.equalTo(self.detailVC!.view.snp_bottom).with.offset(30)
            make.left.equalTo(30)
        }
        
        let paragraph = UILabel(frame: CGRectZero)
        paragraph.setTranslatesAutoresizingMaskIntoConstraints(false)
        paragraph.numberOfLines = 0
        paragraph.textColor = UIColor.whiteColor()
        paragraph.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        paragraph.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tellus metus, posuere et lorem eget, venenatis aliquet purus. Integer volutpat mauris ipsum, at tincidunt mi dictum non. Donec consequat tortor vel neque dapibus euismod. Sed metus eros, facilisis non pulvinar eget, fringilla sed turpis. Cras id pellentesque ligula, ac bibendum libero. Maecenas condimentum mi eros, quis euismod erat sollicitudin eu. Donec pellentesque, ex et sollicitudin vulputate, purus dolor scelerisque neque, id sollicitudin ante sapien in massa."
        self.scrollView.addSubview(paragraph)
        
        paragraph.snp_makeConstraints { (make) -> () in
            make.width.equalTo(self.view.snp_width).with.offset(-60)
            make.left.equalTo(30)
            make.top.equalTo(title.snp_bottom).with.offset(30)
        }
    }
    
    func createOverlay() {
        self.overlay = UIView(frame: CGRectZero)
        self.overlay?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.overlay?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.overlay?.alpha = 0.0
        self.view.addSubview(self.overlay!)
        
        self.overlay?.snp_makeConstraints({ (make) -> () in
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(self.view.snp_height)
            make.left.equalTo(0)
            make.top.equalTo(0)
        })
    }
    
    func createSlideOut() {
        self.slideOut = UIView(frame: CGRectZero)
        self.slideOut?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.slideOut?.backgroundColor = UIColor(red: 0.18, green: 0.212, blue: 0.239, alpha: 1)
        self.slideOut?.layer.shadowColor = UIColor.blackColor().CGColor
        self.slideOut?.layer.shadowOffset = CGSizeMake(0, -4)
        self.slideOut?.layer.shadowRadius = 4
        self.slideOut?.layer.shadowOpacity = 0.25
        self.view.addSubview(self.slideOut!)
        
        let bg = UIImage(named: "bgwave")
        let bgIV = UIImageView(image: bg)
        bgIV.frame = CGRectMake(0, 220 - (bg!.size.height / 2), (bg!.size.width / 2), (bg!.size.height) / 2)
        self.slideOut?.addSubview(bgIV)
        
        let currentConditions = UIImage(named: "conditions")
        let currentConditionsIV = UIImageView(image: currentConditions)
        currentConditionsIV.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.slideOut?.addSubview(currentConditionsIV)
        
        currentConditionsIV.snp_makeConstraints { (make) -> () in
            make.width.equalTo(currentConditions!.size.width / 2)
            make.height.equalTo(currentConditions!.size.height / 2)
            make.centerX.equalTo(self.slideOut!.snp_centerX)
            make.centerY.equalTo(self.slideOut!.snp_centerY).with.offset(-15)
        }
        
        self.slideOut?.snp_makeConstraints({ (make) -> () in
            make.height.equalTo(250)
            make.width.equalTo(self.view.snp_width)
            make.left.equalTo(0)

        })
        
        self.slideOutBottomConstraint = NSLayoutConstraint(item: self.slideOut!, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 270)
        self.view.addConstraint(self.slideOutBottomConstraint!)
    }
    
    func foo(sender:UIBarButtonItem) {
        if self.isInBackground {
            self.bringBack()
        } else {
            self.bringToBackground()
        }
        
        self.isInBackground = !self.isInBackground
    }
    
    func bringBack() {
        // Scale scrollView
        let scrollViewScale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scrollViewScale.toValue = NSValue(CGPoint: CGPointMake(1, 1))
        scrollViewScale.springBounciness = 5.0
        scrollViewScale.springSpeed = 10.0
        self.scrollView.pop_addAnimation(scrollViewScale, forKey: "scrollView.scale")
        
        // Disable events on the scrollView
        self.scrollView.userInteractionEnabled = true
        
        // Overlay
        let overlayOpacity = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        overlayOpacity.toValue = 0.0
        overlayOpacity.springBounciness = 5.0
        overlayOpacity.springSpeed = 10.0
        self.overlay?.pop_addAnimation(overlayOpacity, forKey: "overlay.alpha")
        
        // Animate slideout
        let slideOutMove = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        slideOutMove.toValue = 270
        slideOutMove.springBounciness = 5.0
        slideOutMove.springBounciness = 10.0
        self.slideOutBottomConstraint?.pop_addAnimation(slideOutMove, forKey: "slideout.move")
    }
    
    func bringToBackground() {
        // Scale scrollView
        let scrollViewScale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scrollViewScale.toValue = NSValue(CGPoint: CGPointMake(0.8, 0.8))
        scrollViewScale.springBounciness = 15.0
        scrollViewScale.springSpeed = 5.0
        self.scrollView.pop_addAnimation(scrollViewScale, forKey: "scrollView.scale")
        
        // Enable events on the scrollView
        self.scrollView.userInteractionEnabled = false
        
        // Overlay
        let overlayOpacity = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        overlayOpacity.toValue = 0.25
        overlayOpacity.springBounciness = 15.0
        overlayOpacity.springSpeed = 5.0
        self.overlay?.pop_addAnimation(overlayOpacity, forKey: "overlay.alpha")
        
        // Animate slideout
        let slideOutMove = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        slideOutMove.toValue = 30
        slideOutMove.springBounciness = 15.0
        slideOutMove.springBounciness = 5.0
        slideOutMove.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1)
        self.slideOutBottomConstraint?.pop_addAnimation(slideOutMove, forKey: "slideout.move")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension UIImage {
    public func resize(size:CGSize, completionHandler:(resizedImage:UIImage, data:NSData)->()) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
            var newSize:CGSize = size
            let rect = CGRectMake(0, 0, newSize.width, newSize.height)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            self.drawInRect(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let imageData = UIImageJPEGRepresentation(newImage, 0.5)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completionHandler(resizedImage: newImage, data:imageData)
            })
        })
    }
}
