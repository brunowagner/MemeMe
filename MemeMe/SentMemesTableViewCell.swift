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
    
    let memeTextAttributes : [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeColor: UIColor.black,
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSAttributedStringKey.strokeWidth: -7.0]
    
    func setFontStyle() {
        setAttributes(label: self.labelTop)
        setAttributes(label: self.labelBottom)
        setAttributes(label: self.labelJoin)
    }
    
    private func setAttributes(label : UILabel){
        label.attributedText = NSAttributedString(string: label.text!, attributes: memeTextAttributes)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
    }
}
