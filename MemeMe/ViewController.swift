//
//  ViewController.swift
//  MemeMe
//
//  Created by Bruno W on 21/05/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBarTop: UIToolbar!
    @IBOutlet weak var toolBarBottom: UIToolbar!
    
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
        configureUI(textField: textFieldTop)
        configureUI(textField: textFieldBottom)
        initialState(textField: textFieldTop, withText: Constants.TextFieldTop.text, withId: Constants.TextFieldTop.id)
        initialState(textField: textFieldBottom, withText: Constants.TextFieldBottom.text, withId: Constants.TextFieldBottom.id)
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
            
            if completed {
                self.save(memedImage: memedImage[0])
            }
        }
    }
    
    @IBAction func cancel(_ sender : UIBarButtonItem){
//        meme = Meme.empty()
//        initialState(textField: textFieldTop, withText: Constants.TextFieldTop.text, withId: Constants.TextFieldTop.id)
//        initialState(textField: textFieldBottom, withText: Constants.TextFieldBottom.text, withId: Constants.TextFieldBottom.id)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Functions to generate and save meme
    
    func genereteMemedImage() -> UIImage{
        hideToolbars(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideToolbars(false)
        
        return memedImage
    }
    
    func save(memedImage memed: UIImage){
        //save meme
        meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imagePickerView.image!, memedImage: memed)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    //MARK: Functions to keep code clean and
    
    private func configureUI(textField : UITextField){
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = Constants.minimumFontSize
        imagePickerView.backgroundColor = UIColor.black
    }
    
    private func initialState(textField : UITextField, withText text: String, withId id: String){
        textField.text = text
        textField.restorationIdentifier = id
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
    
    private func hideToolbars(_ hide: Bool){
        toolBarTop.isHidden = hide
        toolBarBottom.isHidden = hide
    }
    
    
}
