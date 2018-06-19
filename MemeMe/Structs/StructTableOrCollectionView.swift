//
//  StructTableOrCollectionView.swift
//  MemeMe
//
//  Created by Bruno W on 18/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit

struct TableOrCollectionView{
    private let tableVC : SentMemesTableViewController!
    private let collectionVC : SentMemesCollectionViewController!
    private let viewController : UIViewController!
    private let meme : [Meme]
    
    init(tableViewController : SentMemesTableViewController) {
        self.tableVC = tableViewController
        self.collectionVC = nil
        viewController = self.tableVC
        meme = self.tableVC.memes
    }
    
    init(collectionViewController : SentMemesCollectionViewController) {
        self.collectionVC = collectionViewController
        self.tableVC = nil
        viewController = self.collectionVC
        self.meme = collectionVC.memes
    }
    
    func openMemeDetail(indexPath : IndexPath){
        let detailVc = self.viewController.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVc.meme = Meme.Data.getMemes()[indexPath.row]
        viewController.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
}
