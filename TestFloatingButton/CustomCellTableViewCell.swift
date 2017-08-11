//
//  CustomCellTableViewCell.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-11.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Toucan

enum HideShowButton {
    case Show, Hide
}

class CustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func willTransition(to state: UITableViewCellStateMask) {

        var userInfo = [String: Any]()
        
        // State where left "-" button is showing || Standard cell state
        if state.rawValue == UInt(1) || state.rawValue == UInt(0) {
            
            userInfo["state"] = HideShowButton.Show

        }
        
        // State where right delete button will show || Cell swipe, right items showing
        if state.rawValue == UInt(3) || state.rawValue == UInt(2) {
            
            userInfo["state"] = HideShowButton.Hide

        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToggleFloatingButton"), object: nil, userInfo: userInfo)
    
    }
    
    func setImage() {
        
        var img: UIImage!
        
        DispatchQueue.global().async {
            
            img = Toucan(image: #imageLiteral(resourceName: "IMG_4869 2")).maskWithEllipse(borderWidth: 4.0, borderColor: UIColor.black).image
         
           /* img = Toucan(image: #imageLiteral(resourceName: "IMG_4869 2")).maskWithPathClosure(path: { (rect) -> (UIBezierPath) in
            
                let path = UIBezierPath()
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                path.close()
                
                path.lineJoinStyle = .round // round UIBezierpath corners

                return path
                
            }).image*/
            
            DispatchQueue.main.async {
         
                self.animalImage.image = img
                
                
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
