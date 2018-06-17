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

    
    let memeTextAttributes : [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeColor: UIColor.black,
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSAttributedStringKey.strokeWidth: -7.0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFontStyle() {
        self.labelTop.attributedText = NSAttributedString(string: self.labelTop.text!, attributes: memeTextAttributes)
        self.labelTop.textAlignment = .center
        self.labelBottom.attributedText = NSAttributedString(string: self.labelBottom.text!, attributes: memeTextAttributes)
        self.labelBottom.textAlignment = .center
        self.labelTop.lineBreakMode = .byTruncatingMiddle
        self.labelBottom.lineBreakMode = .byTruncatingMiddle
    }
    
//    override var isHighlighted:Bool{
//        didSet{
//            print("Highlighted is set \(isHighlighted)")
//        }
//    }
    
}
