//
//  StructTableOrCollectionView.swift
//  MemeMe
//
//  Created by Bruno W on 18/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit

struct Cell{
    private static let memeTextAttributes : [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeColor: UIColor.black,
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        NSAttributedStringKey.strokeWidth: -7.0]
    
    static func setTextAttributes(label:UILabel){
        label.attributedText = NSAttributedString(string: label.text!, attributes: memeTextAttributes)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
    }
    
}
