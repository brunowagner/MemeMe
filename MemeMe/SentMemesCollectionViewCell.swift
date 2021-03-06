//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Bruno W on 11/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView : UIImageView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    
    func setFontAttributes() {
        Cell.setTextAttributes(label: self.labelTop)
        Cell.setTextAttributes(label: self.labelBottom)
    }
}
