//
//  viewControllerExtension.swift
//  MemeMe
//
//  Created by Bruno W on 28/05/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//


import UIKit

//MARK: Structs

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

//MARK: Extension

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Functions of UIImagePickerController protocol
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Functions when KeyBoard Appears and Disappears
    
    func subscriberToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unSubscriberToKeyboardNotifications(){
        //Notifications can be removeds one by one or all at once
        //Following sugestions, i changed to remove all at once.
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification : Notification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification : Notification) -> CGFloat{
        guard textFieldBottom.isFirstResponder else {
            return 0
        }
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
