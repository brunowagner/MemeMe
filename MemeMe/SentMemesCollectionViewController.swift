//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Bruno W on 11/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit
class SentMemesCollectionViewController: UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme]!
    
    override func viewDidLoad() {
        self.memes = self.appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memes = self.appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        cell.imageView.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVc.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
    
}
