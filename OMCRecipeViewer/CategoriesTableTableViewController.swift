//
//  CategoriesTableTableViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let categories = ["spring", "summer", "automn", "winter"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.contentInset = UIEdgeInsetsMake(0.0, 0.0, (self.tabBarController?.tabBar.frame)!.height, 0.0);
        tableView?.register(CategoryTableViewCell.self)
        tableView?.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
        cell.categoryImage.image = UIImage(named: categories[indexPath.row])
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = tabBarController?.tabBar.frame.size.height {
            return (UIScreen.main.bounds.height - height) / 4.0
        }
        return (UIScreen.main.bounds.height / 4.0)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = tabBarController?.tabBar.frame.size.height {
            return (UIScreen.main.bounds.height - height) / 4.0
        }
        return (UIScreen.main.bounds.height / 4.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let vc = RecipesCollectionViewController(collectionViewLayout: layout)
        vc.profileViewControllerDelegate = self
        vc.category = category
        vc.setNavigation = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoriesTableViewController: ProfileViewControllerDelegate {
    func didSelectRecipe(recipe: Recipe, category: String?) {
        let recipeViewController = RecipeViewController(recipe: recipe)
        recipeViewController.category = category
        recipeViewController.user = UserSession.sharedInstance.userSession
        navigationController?.pushViewController(recipeViewController, animated: true)
    }
}
