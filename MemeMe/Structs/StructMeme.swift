//
//  StructMeme.swift
//  MemeMe
//
//  Created by Bruno W on 17/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//
import UIKit

struct Meme{
    var topText : String?
    var bottomText : String?
    var originalImage : UIImage?
    var memedImage : UIImage?
    
    static func empty() -> Meme{
        let memeEmpty = Meme(topText: nil, bottomText: nil, originalImage: nil, memedImage: nil)
        return memeEmpty
    }
    
    static func new() -> Meme{
        let memeNew = Meme(topText: Constants.TextFieldTop.text, bottomText: Constants.TextFieldBottom.text, originalImage: nil, memedImage: nil)
        return memeNew
    }
}
