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
    //MARK: IBOutlets
    @IBOutlet weak var myCollectionView : UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    //MARK: Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme]!
    
    //MARK: viewController`s functions
    override func viewDidLoad() {
        setMemes(self.appDelegate.memes)
        configureFlow()
        activeLongPress()
    }

    override func viewWillAppear(_ animated: Bool) {
        setMemes(self.appDelegate.memes)
        enableEditButton(false)
        reloadData()
    }
    
    //MARK: collectionView`s functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        cell.myImageView.image = memes[indexPath.row].originalImage
        cell.labelTop.text = memes[indexPath.row].topText
        cell.labelBottom.text = memes[indexPath.row].bottomText
        cell.setFontStyle()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVc.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailVc, animated: true)
    }

    //MARK: Segueway`s functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeEditorVC = segue.destination as! ViewController
        
        switch segue.identifier {
            
        case "SegueEditMeme":
            let indexPath = self.collectionView!.indexPathsForSelectedItems![0]
            memeEditorVC.meme = self.memes[indexPath.row]
            break
        default: break //do not set meme in viewController
        }
    }
    
    //MARK: Auxiliaries functions
    func enableEditButton(_ enable: Bool){
        editButton.isEnabled = enable
    }
    
    func setMemes (_ memeArray: [Meme]){
        self.memes = memeArray
    }
    
    func configureFlow(){
        let space : CGFloat = 1.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        //let height = (view.frame.size.height - space)/4.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: width)
    }
    
    func activeLongPress(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        myCollectionView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
            let touchPoint = sender.location(in: myCollectionView)
            if let indexPath = myCollectionView.indexPathForItem(at: touchPoint) {
                myCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init(rawValue: UInt(indexPath.item)))
                enableEditButton(true)
            }
        }
    }

    func reloadData(){
        self.collectionView?.reloadData()
    }
}
