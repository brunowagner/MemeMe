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
    
    let memes = (UIApplication.shared.delegate as! AppDelegate).memes

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell")!
        cell.imageView!.image = memes[indexPath.row].memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        datailViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(datailViewController, animated: true)
    }
}
