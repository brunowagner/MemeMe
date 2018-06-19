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
    
    struct TextAttributes{
        private static let strokeColor = UIColor.black
        private static let foregroundColor = UIColor.white
        private static let fontName = "HelveticaNeue-CondensedBlack"
        private static let fontsize = 40
        private static let strokeWidth = -7.0
        
        static func label()->[NSAttributedStringKey : Any]{
            return [
                NSAttributedStringKey.strokeColor: self.strokeColor,
                NSAttributedStringKey.foregroundColor: self.foregroundColor,
                NSAttributedStringKey.font: UIFont(name: self.fontName, size: 15)!,
                NSAttributedStringKey.strokeWidth: self.strokeWidth
            ]
        }
        
        static func textField() -> [String:Any]{
            return [
                NSAttributedStringKey.strokeColor.rawValue: self.strokeColor,
                NSAttributedStringKey.foregroundColor.rawValue: self.foregroundColor,
                NSAttributedStringKey.font.rawValue: UIFont(name: self.fontName, size: 40)!,
                NSAttributedStringKey.strokeWidth.rawValue: self.strokeWidth
            ]
        }
    }
}
