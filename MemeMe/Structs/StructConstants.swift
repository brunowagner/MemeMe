//
//  StructConstants.swift
//  MemeMe
//
//  Created by Bruno W on 17/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//
import UIKit

struct Constants {
    struct TextFieldTop {
        static let text = "TOP"
        static let id = "TextFieldTop"
    }
    struct TextFieldBottom {
        static let text = "BOTTOM"
        static let id = "TextFieldBottom"
    }
    
    static let minimumFontSize : CGFloat = 16.0
    
    static func isDefaultText(_ textField: UITextField)-> Bool{
        var validate = false
        if textField.restorationIdentifier == Constants.TextFieldTop.id && textField.text?.uppercased() == Constants.TextFieldTop.text{
            validate = true
        }
        if textField.restorationIdentifier == Constants.TextFieldBottom.id && textField.text?.uppercased() == Constants.TextFieldBottom.text{
            validate = true
        }
        return validate
    }  
}
