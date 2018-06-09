//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Bruno W on 07/06/2018.
//  Copyright © 2018 Bruno_W. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController : UITableViewController{
    
    let appDelegation = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme]!
    
    override func viewDidLoad() {
        self.memes = appDelegation.memes
    }

    override func viewWillAppear(_ animated: Bool) {
        self.memes = appDelegation.memes
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell")!
        cell.imageView!.image = self.memes[indexPath.row].memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        datailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(datailViewController, animated: true)
    }
}
