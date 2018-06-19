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
    
    //MARK: IBOutlets
    @IBOutlet weak var myTableView : UITableView!
    
    //MARK: Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme]!
    
    //MARK: viewController`s functions
    override func viewDidLoad() {
        setMemes(self.appDelegate.memes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMemes(self.appDelegate.memes)
        reloadData()
    }
    
    //MARK: tableView`s functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadData()
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell") as! SentMemesTableViewCell
        cell.myImageView.image = self.memes[indexPath.row].originalImage
        cell.labelTop.text = self.memes[indexPath.row].topText
        cell.labelBottom.text = self.memes[indexPath.row].bottomText
        cell.labelJoin.text = "\(self.memes[indexPath.row].topText ?? "")    \(self.memes[indexPath.row].bottomText ?? "")"
        cell.setFontStyle()
        //configureCell(cell)
        return cell
    }
    
    func configureCell(_ cell: SentMemesTableViewCell){
        let width = (view.frame.size.width - 2) / 3
        cell.myImageView.frame.size = CGSize(width: width, height: width)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        datailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(datailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            deleteMeme(indexPath)
        }
    }

    //MARK: Segueway`s functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeEditorVC = segue.destination as! EditorViewController
        
        switch segue.identifier {

        case "SegueEditMeme":
            let item = myTableView.indexPathForSelectedRow?.row
            memeEditorVC.meme = self.memes[item!]
            break
        default: break //do not set meme in viewController
        }
    }
    
    //MARK: Auxiliaries functions
    func deleteMeme(_ item: IndexPath){
        appDelegate.memes.remove(at: item.row)
        setMemes(appDelegate.memes)
        myTableView.deleteRows(at: [item], with: .automatic)
    }
    
    func setMemes (_ memeArray: [Meme]){
        self.memes = memeArray
    }
    
    func reloadData(){
        self.tableView?.reloadData()
    }


}
