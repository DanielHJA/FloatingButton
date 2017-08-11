//
//  CustomCellTableViewCell.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-11.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum HideShowButton {
    case Show, Hide
}

class CustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage() {
        
        let img: UIImage = #imageLiteral(resourceName: "IMG_4869 2")
        
    }
    
    override func willTransition(to state: UITableViewCellStateMask) {

        var userInfo = [String: Any]()
        
        // State where left "-" button is showing
        if state.rawValue == UInt(1) {
            
            userInfo["state"] = HideShowButton.Show

        }
        
        // State where right delete button will show
        if state.rawValue == UInt(3) {
            
            userInfo["state"] = HideShowButton.Hide

        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ToggleFloatingButton"), object: nil, userInfo: userInfo)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
