//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Bruno W on 08/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var meme : Meme!
    
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = meme.memedImage
        hideTabBar(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideTabBar(false)
    }

    func hideTabBar(_ chose: Bool){
        self.tabBarController?.tabBar.isHidden = chose
    }

}
