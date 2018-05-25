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
}
