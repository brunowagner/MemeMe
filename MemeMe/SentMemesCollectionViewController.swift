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
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    //MARK: Properties
    var memes : [Meme]!
    
    //MARK: viewController`s functions
    override func viewDidLoad() {
        setMemes()
        configureFlow()
    }

    override func viewWillAppear(_ animated: Bool) {
        setMemes()
        reloadCollection()
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
        cell.setFontAttributes()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    //MARK: Auxiliaries functions
    func setMemes (){
        self.memes = Meme.Data.getMemes()
    }
    
    func configureFlow(){
        let space : CGFloat = 1.0
        let width = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: width)
    }

    func reloadCollection(){
        self.collectionView?.reloadData()
    }
}
