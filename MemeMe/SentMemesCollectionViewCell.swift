//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Bruno W on 11/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    
    private let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -7.0]
    
    let teste : [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeColor: UIColor.black,
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSAttributedStringKey.strokeWidth: -2.0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelTop.lineBreakMode = .byTruncatingMiddle
        self.labelBottom.lineBreakMode = .byTruncatingMiddle

        
    }
    
    func setFontStyle() {
        self.labelTop.attributedText = NSMutableAttributedString(string: self.labelTop.text ?? "", attributes: teste)
        
        self.labelBottom.attributedText = NSMutableAttributedString(string: self.labelBottom.text ?? "", attributes: teste)
        self.labelTop.textAlignment = .center
        self.labelBottom.textAlignment = .center
    }
    
}
