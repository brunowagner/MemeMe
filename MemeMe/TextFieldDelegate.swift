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
        //Remove default text
        if textField.text?.lowercased() == "top"{
            textField.text = ""
        }
        if textField.text?.lowercased() == "bottom"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
