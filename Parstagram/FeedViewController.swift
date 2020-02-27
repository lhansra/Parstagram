//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Lovpreet Hansra on 2/25/20.
//  Copyright © 2020 Lovpreet Hansra. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["owner"] as! PFUser
        let caption = post["caption"]
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = caption as! String
        let file = post["image"] as! PFFileObject
        let urlString = file.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKey("owner")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
