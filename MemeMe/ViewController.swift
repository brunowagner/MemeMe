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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var meme : Meme = Meme.empty()
    
    let textFieldDelegate = TextFieldDelegate()
    
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -7.0]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"

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

    @IBAction func pickeAnPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func pickerAnImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
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
    
    //MARK: Functions to generate, cancel, save and share meme
    
    func genereteMemedImage() -> UIImage{
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    //MARK: funcao temporaria
    func save(memedImage memed: UIImage){
        //create the meme
        meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imagePickerView.image!, memedImage: memed)
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem){
        
        let memedImage = [genereteMemedImage()]
        //    gerar uma imagem com meme
        //    definir uma instância do ActivityViewController
        //    aprovar o memedImage no ActivityViewController como um item de atividade
        //    apresentar o ActivityViewController
        
        let avc = UIActivityViewController(activityItems: memedImage, applicationActivities: nil)
        
        present(avc, animated: true, completion: nil)
        
        avc.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            
            if completed == true {
                self.save(memedImage: memedImage[0])
                print("topText: \(self.meme.topText!)")
                print("bottomText: \(self.meme.bottomText!)")
            }
        }
    }
    
    @IBAction func clearMeme(sender : UIBarButtonItem){
        meme = Meme.empty()
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
}
