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
    
    static func setTextAttributes(label:UILabel){
        label.attributedText = NSAttributedString(string: label.text!, attributes:Constants.TextAttributes.label())
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
    }
}
