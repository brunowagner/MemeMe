//
//  Memebkp.swift
//  MemeMe
//
//  Created by Bruno W on 18/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import UIKit

struct Memebkp{
    var topText : String?
    var bottomText : String?
    var originalImage : UIImage?
    var memedImage : UIImage?
    
    static func empty() -> Memebkp{
        let memeEmpty = Memebkp(topText: nil, bottomText: nil, originalImage: nil, memedImage: nil)
        return memeEmpty
    }
    
    static func new() -> Memebkp{
        let memeNew = Memebkp(topText: Constants.TextFieldTop.text, bottomText: Constants.TextFieldBottom.text, originalImage: nil, memedImage: nil)
        return memeNew
    }
}
