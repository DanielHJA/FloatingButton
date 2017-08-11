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

enum AnimationType {
    case Rotate, Stretch, Jump
}

class FloatingButton: UIButton {
    
    var bottomConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!

    var delegate: FloatingButtonProtocol?
    var buttonLayer: CAShapeLayer!
    var width: CGFloat = 0.0
    var height : CGFloat = 0.0
    var hasShadow: Bool = false
    var buttonFillColor: CGColor!
    var buttonShape: ButtonShape = .Circle
    var animation: AnimationType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(width: CGFloat, height: CGFloat, fillColor: UIColor, buttonShape: ButtonShape, hasShadow: Bool, animation: AnimationType?) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
        self.width = width
        self.height = height
        self.buttonFillColor = fillColor.cgColor
        self.buttonShape = buttonShape
        self.hasShadow = hasShadow
        self.animation = animation
        
        translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchDown)
        
        addLayer()
        
        if let superV = self.superview {
            superV.bringSubview(toFront: self)
        }
    }
    
    func addLayer(){
    
        buttonLayer = CAShapeLayer()
        buttonLayer.frame = bounds
        buttonLayer.backgroundColor = UIColor.clear.cgColor
        buttonLayer.fillColor = buttonFillColor
        buttonLayer.path = returnButtonShape()
        
        if hasShadow {
            
            buttonLayer.shadowColor = UIColor.black.cgColor
            buttonLayer.shadowOpacity = 0.7
            buttonLayer.shadowRadius = 5.0
            buttonLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            
        }
        
        layer.addSublayer(buttonLayer)
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
        
        animate()
        
        self.isSelected = !self.isSelected
        
        self.delegate?.buttonPressed(isButtonSelected: self.isSelected)
        
    }
    
    func animate() {
    
        if let animationType = animation {
        
            switch animationType {
                case .Rotate:
                    rotationgAnimation()
                case .Stretch:
                    stretchAnimation()
                case .Jump:
                    jumpAnimation()
            }
        }
    }
    
    func rotationgAnimation() {

        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.duration = 0.3
        fullRotation.repeatCount = 1
        fullRotation.isRemovedOnCompletion = true
        
        if !isSelected {
            
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
            
        } else {
            
        fullRotation.fromValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.toValue = NSNumber(floatLiteral: 0)
            
        }
        
        buttonLayer.add(fullRotation, forKey: "360")
        
    }
    
    func stretchAnimation() {
    
        UIView.animate(withDuration: 0.2) {
            
            if !self.isSelected {
                
                self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                
            } else {
                
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            }
        }
    }
    
    func jumpAnimation() {
    
        let jumpAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            jumpAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            jumpAnimation.duration = 0.1
            jumpAnimation.repeatCount = 1
            jumpAnimation.autoreverses = true
            jumpAnimation.isRemovedOnCompletion = true
            jumpAnimation.toValue = -25.0
            buttonLayer.add(jumpAnimation, forKey: "jumpAnimation")
    }
}
