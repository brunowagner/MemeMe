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
        self.labelTop.attributedText = NSAttributedString(string: self.labelTop.text!, attributes: memeTextAttributes)
        self.labelTop.textAlignment = .center
        self.labelBottom.attributedText = NSAttributedString(string: self.labelBottom.text!, attributes: memeTextAttributes)
        self.labelBottom.textAlignment = .center
        self.labelJoin.attributedText = NSAttributedString(string: self.labelJoin.text!, attributes: memeTextAttributes)
        self.labelJoin.textAlignment = .center
    }
}
