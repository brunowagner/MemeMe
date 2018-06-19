//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Bruno W on 15/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView : UIImageView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var labelJoin: UILabel!
    
    func setFontAttributes() {
        Cell.setTextAttributes(label: self.labelTop)
        Cell.setTextAttributes(label: self.labelBottom)
        Cell.setTextAttributes(label: self.labelJoin)
    }
}
