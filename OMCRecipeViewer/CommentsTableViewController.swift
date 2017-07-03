//
//  CommentsTableViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    var comments: [Comment] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar(title: "comments")
        tableView.register(CommentTableViewCell.self)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView?.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendComment(text: String) {
        guard let userID = UserSession.sharedInstance.userSession?.id,
              let recipeID = recipe?.ID else { return }
        CommentRecipeRequest(userID: userID, recipeID: recipeID, data: text).perform {
            result in
            self.comments.append(result)
            self.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count 
    }

    func reloadData() {
        tableView?.reloadData()
        if comments.count <= 0 {
            tableView?.backgroundView?.isHidden = false
            showNoContent(msg: "No comments for this recipe")
        } else {
            tableView?.backgroundView?.isHidden = true
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CommentTableViewCell
        let comment = comments[indexPath.row]
        cell.comment.text = comment.data
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = formatter.string(from: comment.creation_date)
        cell.date.text = date
        cell.user.text = "\(comment.user.firstname) \(comment.user.lastname)"
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
