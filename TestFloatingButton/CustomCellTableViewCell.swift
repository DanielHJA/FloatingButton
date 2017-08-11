//
//  CustomCellTableViewCell.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-11.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage() {
    
        let img: UIImage = #imageLiteral(resourceName: "IMG_4869 2")
        
    
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
