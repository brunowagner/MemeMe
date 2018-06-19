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
    var memes : [Meme]!
    
    //MARK: viewController`s functions
    override func viewDidLoad() {
        setMemes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMemes()
        reloadTable()
    }
    
    //MARK: tableView`s functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadTable()
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell") as! SentMemesTableViewCell
        
        cell.myImageView.image = self.memes[indexPath.row].originalImage
        cell.labelTop.text = self.memes[indexPath.row].topText
        cell.labelBottom.text = self.memes[indexPath.row].bottomText
        cell.labelJoin.text = "\(self.memes[indexPath.row].topText ?? "")    \(self.memes[indexPath.row].bottomText ?? "")"
        cell.setFontStyle()
        return cell
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
    
    //MARK: Auxiliaries functions
    func deleteMeme(_ item: IndexPath){
        Meme.Data.deleteMeme(at: item.row)
        setMemes()
        myTableView.deleteRows(at: [item], with: .automatic)
    }
    
    func setMemes (){
        self.memes = Meme.Data.getMemes()
    }
    
    func reloadTable(){
        self.tableView?.reloadData()
    }


}
