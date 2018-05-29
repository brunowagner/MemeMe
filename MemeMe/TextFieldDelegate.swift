//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Bruno W on 22/05/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        removeDefaultText(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func removeDefaultText(_ textField: UITextField){
        if Constants.isDefaultText(textField){
            textField.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text : NSString = textField.text! as NSString
        text = text.replacingCharacters(in: range, with: string) as NSString

        //to limit text at textfield dynamically
        let textSize : CGSize = text.size(withAttributes: [NSAttributedStringKey.font : textField.font!])
        let textSizeOk = textSize.width < textField.bounds.size.width ? true : false
        
        //to write big words without stop by textField bounds
        let fontSizeOk = textField.font!.pointSize > Constants.minimumFontSize ? true : false

        return fontSizeOk || textSizeOk ? true : false
    }
    
    
}
