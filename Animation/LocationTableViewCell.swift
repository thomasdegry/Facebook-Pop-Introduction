//
//  LocationTableViewCell.swift
//  Animation
//
//  Created by LOANER on 3/14/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

protocol LocationDelegate {
    func showLocationFor(cell:LocationTableViewCell)
    func didSetNewDetailCell(cell:LocationTableViewCell)
    func didUnsetDetailCell(cell:LocationTableViewCell)
}

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var imageBW: UIImageView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleDetail:")
            self.imageBW.userInteractionEnabled = true
            self.imageBW.addGestureRecognizer(gestureRecognizer)
        }
    }
    @IBOutlet weak var imageColor: UIImageView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleDetail:")
            self.imageColor.userInteractionEnabled = true
            self.imageColor.addGestureRecognizer(gestureRecognizer)
        }
    }
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            setupLocationLabel()
        }
    }
    @IBOutlet weak var stateLabel: UILabel! {
        didSet {
            setupStateLabel()
        }
    }
    @IBOutlet weak var detailView: UIView! {
        didSet {
            self.detailView.layer.backgroundColor = UIColor(red: 0.184, green: 0.216, blue: 0.243, alpha: 1.0).CGColor
            self.detailView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI/2), 1.0, 0.0, 0.0)
            self.detailView.layer.anchorPoint = CGPointMake(0.5, 1.0)
        }
    }
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var locationTopConstraint: NSLayoutConstraint!
    
    var delegate:LocationDelegate?
    var wasInitted:Bool = false
    var isShowingDetail:Bool = false
    var location:Location? {
        didSet {
            if !wasInitted {
                self.wasInitted = true
                self.comeIn()
            }
            update()
        }
    }
    
    func setupLocationLabel() {
        self.locationLabel.layer.shadowColor = UIColor.blackColor().CGColor
        self.locationLabel.layer.shadowRadius = 1.0
        self.locationLabel.layer.shadowOffset = CGSizeMake(0, 1)
        self.locationLabel.layer.shadowOpacity = 0.5
    }
    
    func setupStateLabel() {
        self.stateLabel.layer.shadowColor = UIColor.blackColor().CGColor
        self.stateLabel.layer.shadowRadius = 1.0
        self.stateLabel.layer.shadowOffset = CGSizeMake(0, 1)
        self.stateLabel.layer.shadowOpacity = 0.5
    }
    
    func toggleDetail(sender:UITapGestureRecognizer) {
        if self.isShowingDetail {
            self.delegate?.didUnsetDetailCell(self)
            self.hideDetail()
        } else {
            self.delegate?.didSetNewDetailCell(self)
            self.showDetail()
        }
    }
    
    @IBAction func detailTapped(sender: UIButton) {
        self.delegate?.showLocationFor(self)
    }
    
    func comeIn() {
        var transform:CGAffineTransform = self.wrapper.transform
        transform = CGAffineTransformScale(transform, 0.9, 0.9)
        self.wrapper.transform = transform
        self.wrapper.alpha = 0.0
        
        var delay:Float = self.location!.delay
        
        let scaleIn = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scaleIn.springSpeed = 5.0
        scaleIn.springBounciness = 15.0
        scaleIn.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        scaleIn.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        self.wrapper.pop_addAnimation(scaleIn, forKey: "scale.init")
        
        let opacityIn = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        opacityIn.springSpeed = 5.0
        opacityIn.springBounciness = 15.0
        opacityIn.toValue = 1.0
        opacityIn.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        self.wrapper.pop_addAnimation(opacityIn, forKey: "opacity.init")
    }
    
    func update() {
        self.imageBW.image = UIImage(named: location!.image)
        self.imageColor.image = UIImage(named: location!.image + "-color")
        self.locationLabel.text = location!.place
        self.stateLabel.text = location!.state
        self.latitudeLabel.text = location!.lat
        self.longitudeLabel.text = location!.long
    }
    
    func showDetail() {
        self.isShowingDetail = true
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.additive = false
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.toValue = CGFloat(0.0)
        self.detailView.layer.transform = CATransform3DMakeRotation(0.0, 1.0, 0.0, 0.0)
        self.detailView.layer.addAnimation(animation, forKey: "flipup")
                
        let bwAnimationOpacity = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        bwAnimationOpacity.toValue = 0.0
        self.imageBW.pop_addAnimation(bwAnimationOpacity, forKey: "bw.opacity")
        
        let topConstraintAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        topConstraintAnimation.springSpeed = 5.0
        topConstraintAnimation.springBounciness = 15.0
        topConstraintAnimation.toValue = 80
        self.locationTopConstraint.pop_addAnimation(topConstraintAnimation, forKey: "location.constraint.top")
    }
    
    func hideDetail() {
        self.isShowingDetail = false
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.additive = false
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.toValue = CGFloat(-M_PI/2)
        self.detailView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI/2), 1.0, 0.0, 0.0)
        self.detailView.layer.addAnimation(animation, forKey: "flipdown")
        
        let bwAnimationOpacity = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        bwAnimationOpacity.toValue = 1.0
        self.imageBW.pop_addAnimation(bwAnimationOpacity, forKey: "bw.opacity")
        
        let topConstraintAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        topConstraintAnimation.springSpeed = 5.0
        topConstraintAnimation.springBounciness = 15.0
        topConstraintAnimation.toValue = 40
        topConstraintAnimation.beginTime = CFTimeInterval(3.0)
        self.locationTopConstraint.pop_addAnimation(topConstraintAnimation, forKey: "location.constraint.top")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 0.184, green: 0.216, blue: 0.243, alpha: 1)
    }

}
