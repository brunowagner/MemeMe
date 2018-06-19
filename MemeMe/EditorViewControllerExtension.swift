//
//  viewControllerExtension.swift
//  MemeMe
//
//  Created by Bruno W on 28/05/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//


import UIKit

//MARK: Extension

extension EditorViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
