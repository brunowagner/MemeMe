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
    
    
    @IBOutlet weak var myTableView : UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let appDelegation = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme]!
    
    override func viewDidLoad() {
        self.memes = appDelegation.memes
        editButton.isEnabled = false
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        myTableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
            let touchPoint = sender.location(in: myTableView)
            if let indexPath = myTableView.indexPathForRow(at: touchPoint) {
                myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                editButton.isEnabled = true
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.memes = appDelegation.memes
        editButton.isEnabled=false
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
        editButton.isEnabled = false


        let datailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        datailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(datailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            deleteMeme(indexPath)
        }
    }
    
    func deleteMeme(_ item: IndexPath){
        appDelegation.memes.remove(at: item.row)
        self.memes = appDelegation.memes
        myTableView.deleteRows(at: [item], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeEditorVC = segue.destination as! ViewController
        
        switch segue.identifier {

        case "SegueEditMeme":
            let item = myTableView.indexPathForSelectedRow?.row
            memeEditorVC.meme = self.memes[item!]
            break
        default: break //do not set meme in viewController
        }
    }

}
