//
//  FloatingButton.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-10.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {

    let touchDownColor: CGColor = UIColor.green.cgColor
    let touchExitColor: CGColor = UIColor.red.cgColor
    
    var circleLayer: CAShapeLayer!
    
    var width: CGFloat = 0.0
    var height : CGFloat = 0.0
    var hasShadow: Bool = false
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
        self.width = width
        self.height = height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchDown)
        self.addTarget(self, action: #selector(touchExit), for: UIControlEvents.touchUpInside)
    
        translatesAutoresizingMaskIntoConstraints = false
        
        circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.fillColor = touchExitColor
        circleLayer.backgroundColor = UIColor.clear.cgColor
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.shadowOpacity = 0.7
        circleLayer.shadowRadius = 5.0
        circleLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.addSublayer(circleLayer)
        
        if let superV = self.superview {
        
            superV.bringSubview(toFront: self)
        
        }
    }
    
    func addShadow() {
    
    }
    
    func returnCircularButton() -> CGPath {
    
    }
    
    func returnSquareButton() -> CGPath {
    
    }
    
    func returnRoundedCornersButton() -> CGPath {
    
    }
    
    func returnTriangleButton() -> CGPath {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if let superV = self.superview {
        
            let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superV, attribute: .bottom, multiplier: 1.0, constant: -5.0)
            let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailingMargin, relatedBy: .equal, toItem: superV, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0)
            let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: width)
            let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: height)
            superV.addConstraints([bottomConstraint, trailingConstraint, widthConstraint, heightConstraint])
            
        }
    }
    
    func touchUpInside() {
        circleLayer.fillColor = touchDownColor
    }
    
    func touchExit(sender: UIControl) {
        circleLayer.fillColor = touchExitColor
    }
}
