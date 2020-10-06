//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Melissa on 10/5/20.
//  Copyright © 2020 Melissa Ma. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // make a query
        let query = PFQuery(className:"Posts")
        // without key, pointer without object
        query.includeKey("author")
        query.limit = 30
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        let imageFile = post["photo"] as! PFFileObject
        let imageURL = imageFile.url!
        let url = URL(string: imageURL)!
        
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        cell.photoView.af.setImage(withURL: url)
        
        return cell
    }
       
    

}
