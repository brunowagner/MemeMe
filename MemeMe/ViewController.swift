//
//  ViewController.swift
//  MemeMe
//
//  Created by Bruno W on 21/05/2018.
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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: IBOutlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    //MARK: Properties
    private var meme : Meme = Meme.empty()
    private let textFieldDelegate = TextFieldDelegate()
    private let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -7.0]
    
    //MARK: Functions of ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shareButton.isEnabled = imagePickerView.image == nil ? false : true
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscriberToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSubscriberToKeyboardNotifications()
    }
    
    //MARK: IBActions
    @IBAction func pickerPhotoOrImage(_ sender : UIBarButtonItem){
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sender.title! == "Album" ? .photoLibrary : .camera
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem){
        let memedImage = [genereteMemedImage()]
        let controller = UIActivityViewController(activityItems: memedImage, applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            
            if completed == true {
                self.save(memedImage: memedImage[0])
                print("topText: \(self.meme.topText!)")
                print("bottomText: \(self.meme.bottomText!)")
            }
        }
    }
    
    @IBAction func clearMeme(sender : UIBarButtonItem){
        meme = Meme.empty()
        initialState()
    }
    
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
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
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
    
    //MARK: Functions to generate and save meme
    
    func genereteMemedImage() -> UIImage{
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }

    func save(memedImage memed: UIImage){
        //create the meme
        meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imagePickerView.image!, memedImage: memed)
    }

    //MARK: Functions to keep code clean
    
    private func configureUI(){
        textFieldTop.delegate = textFieldDelegate
        textFieldBottom.delegate = textFieldDelegate
        textFieldTop.defaultTextAttributes = memeTextAttributes
        textFieldBottom.defaultTextAttributes = memeTextAttributes
        textFieldTop.backgroundColor = UIColor.clear
        textFieldBottom.backgroundColor = UIColor.clear
        textFieldTop.textAlignment = .center
        textFieldBottom.textAlignment = .center
        textFieldTop.borderStyle = .none
        textFieldBottom.borderStyle = .none
        textFieldTop.adjustsFontSizeToFitWidth = true
        textFieldBottom.adjustsFontSizeToFitWidth = true
        textFieldTop.minimumFontSize = Constants.minimumFontSize
        textFieldBottom.minimumFontSize = Constants.minimumFontSize
        imagePickerView.backgroundColor = UIColor.black
    }
    
    private func initialState(){
        textFieldTop.text = Constants.TextFieldTop.text
        textFieldBottom.text = Constants.TextFieldBottom.text
        textFieldTop.restorationIdentifier = Constants.TextFieldTop.id
        textFieldBottom.restorationIdentifier = Constants.TextFieldBottom.id
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
}
