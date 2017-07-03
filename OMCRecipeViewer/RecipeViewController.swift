//
//  RecipeViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 17/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeViewControllerDelegate: class {
    func didTapAuthor()
    func didTapComment(comments: [Comment])
}

class RecipeViewController: UIViewController {
    var recipe: Recipe
    var category: String?
    var recipeView: RecipeView1
    var pageViewController: RecipePageViewController?
    var user: User?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.recipeView = RecipeView1.instantiate()
        pageViewController = RecipePageViewController(recipe: recipe)
        self.recipeView.recipe = recipe
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeView.delegate = self
        if let category = self.category {
            setNavBar(title: "Recipe for " + category)
        } else {
            setNavBar(title: "Recipe view")
        }
        self.view.addSubview(recipeView)
        recipeView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        recipeView.autoPinEdge(toSuperviewEdge: .leading)
        recipeView.autoPinEdge(toSuperviewEdge: .trailing)
        
        self.view.addSubview((pageViewController?.view)!)
        pageViewController?.view.autoPinEdge(.top, to: .bottom, of: recipeView)
        pageViewController?.view.autoPinEdge(toSuperviewEdge: .leading)
        pageViewController?.view.autoPinEdge(toSuperviewEdge: .trailing)
        pageViewController?.view.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = self.user else { return }
        recipeView.setInfos(user: user)
    }
}

extension RecipeViewController: RecipeViewControllerDelegate {
    func didTapAuthor() {
        let author = recipe.user
        let vc = ProfileViewController1()
        vc.user = author
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func didTapComment(comments: [Comment]) {
        let dstVC = CommentsViewController(recipe: recipe, comments: comments)
        self.navigationController?.pushViewController(dstVC, animated: true)
    }
}
