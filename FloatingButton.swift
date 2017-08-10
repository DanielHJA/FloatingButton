//
//  FloatingButton.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-10.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol FloatingButtonProtocol {
    func buttonPressed(isButtonSelected: Bool)
}

enum ButtonShape {
    case Circle, Square, Rounded, Triangle, FiveDot
}

class FloatingButton: UIButton {
    
    var bottomConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!

    var delegate: FloatingButtonProtocol?
    var circleLayer: CAShapeLayer!
    var width: CGFloat = 0.0
    var height : CGFloat = 0.0
    var hasShadow: Bool = false
    var buttonFillColor: CGColor!
    var buttonShape: ButtonShape = .Circle
    
    convenience init(width: CGFloat, height: CGFloat, fillColor: UIColor, buttonShape: ButtonShape, hasShadow: Bool) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
        self.width = width
        self.height = height
        self.buttonFillColor = fillColor.cgColor
        self.buttonShape = buttonShape
        self.hasShadow = hasShadow
        
        translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchDown)
        //self.addTarget(self, action: #selector(touchExit), for: UIControlEvents.touchUpInside)
        
        circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.backgroundColor = UIColor.clear.cgColor
        circleLayer.fillColor = buttonFillColor
        circleLayer.path = returnButtonShape()
        
        if hasShadow {
            
            circleLayer.shadowColor = UIColor.black.cgColor
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowRadius = 5.0
            circleLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            
        }
        
        layer.addSublayer(circleLayer)
        
        if let superV = self.superview {
            
            superV.bringSubview(toFront: self)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func returnButtonShape() -> CGPath {
    
        switch buttonShape {
            case .Circle:
                return returnCircularPath()
            case .Rounded:
                return returnRoundedCornersPath()
            case .Square:
                return returnSquarePath()
            case .Triangle:
                return returnTrianglePath()
            case .FiveDot:
                return returnFiveDotPath()
            }
        }

    func returnCircularPath() -> CGPath {
        return UIBezierPath(ovalIn: bounds).cgPath
    }
    
    func returnSquarePath() -> CGPath {
        return UIBezierPath(rect: bounds).cgPath
    }
    
    func returnRoundedCornersPath() -> CGPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: 10.0).cgPath
    }
    
    func returnTrianglePath() -> CGPath {
        
        let trianglePath = UIBezierPath()
        
        trianglePath.move(to: CGPoint(x: 0, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.midX, y: 0))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.close()
        
        return trianglePath.cgPath
    }
    
    func returnFiveDotPath() -> CGPath {
    
        let radius = bounds.width / 7
        let fiveLayer = UIBezierPath()
        
        fiveLayer.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
        
            fiveLayer.addArc(withCenter: CGPoint(x: bounds.minX + radius, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        fiveLayer.move(to: CGPoint(x: bounds.midX, y: bounds.midY))

            fiveLayer.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)

        fiveLayer.move(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        
            fiveLayer.addArc(withCenter: CGPoint(x: bounds.maxX - radius, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        fiveLayer.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        
            fiveLayer.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.minY + radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        fiveLayer.move(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        
            fiveLayer.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.maxY - radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        return fiveLayer.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if let superV = self.superview {
        
            bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superV, attribute: .bottom, multiplier: 1.0, constant: -5.0)
          
            trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailingMargin, relatedBy: .equal, toItem: superV, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0)
            
            widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: width)
            
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: height)
            
            superV.addConstraints([bottomConstraint, trailingConstraint, widthConstraint, heightConstraint])
            
        }
    }
    
    func touchUpInside() {
        
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.duration = 0.3
        fullRotation.repeatCount = 1
        
        if !isSelected {
            
            fullRotation.fromValue = NSNumber(floatLiteral: 0)
            fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
            
        } else {
            
            fullRotation.fromValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
            fullRotation.toValue = NSNumber(floatLiteral: 0)
            
        }
        
        circleLayer.add(fullRotation, forKey: "360")
        
        self.isSelected = !self.isSelected
        
        self.delegate?.buttonPressed(isButtonSelected: self.isSelected)
        
    }
    
    /*func touchExit(sender: UIControl) {}*/
}
