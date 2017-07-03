//
//  ProfileViewController.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit
import PureLayout

protocol ProfileViewControllerDelegate: class {
    func didSelectRecipe(recipe: Recipe, category: String?)
}

class ProfileViewController1: UIViewController {

    var profileView: ProfileView1
    var recipesCollectionViewController: RecipesCollectionViewController?
    var followers: [User] = []
    var following: [User] = []
    var user: User?
    
    init() {
        profileView = ProfileView1.instantiate()
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user?.email == UserSession.sharedInstance.userSession?.email {
            setNavBar(title: "My Recipes")
            NotificationCenter.default.addObserver(self, selector: #selector(userChanged), name: NSNotification.Name(rawValue: "userChanged"), object: nil)
        } else {
            if let user = self.user {
                setNavBar(title: "\(user.firstname) \(user.lastname)'s Recipes")
            }
        }
        profileView.user = user
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 0)
        recipesCollectionViewController = RecipesCollectionViewController(collectionViewLayout: layout)
        recipesCollectionViewController?.profileViewControllerDelegate = self
        self.view.addSubview(profileView)
        profileView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        profileView.autoPinEdge(toSuperviewMargin: .leading)
        profileView.autoPinEdge(toSuperviewMargin: .trailing)
        profileView.autoSetDimension(.height, toSize: 115)
        self.view.backgroundColor = UIColor.white
        guard let collectionView = recipesCollectionViewController?.view else {
            return
        }
        self.view.addSubview(collectionView)
        collectionView.autoPinEdge(.top, to: .bottom, of: profileView)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = self.user else { return }
        profileView.setFollowersAndFollowing()
        profileView.setInfos(user: user)
        loadRecipes(user: user)
    }
    
    func loadRecipes(user: User) {
        recipesCollectionViewController?.collectionView?.activityIndicatorView.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async {
            // Bounce back to the main thread to update the UI
                RecipesFromUserRequest(userID: user.id).perform { recipes in
                    DispatchQueue.main.async {
                        self.recipesCollectionViewController?.recipes = recipes
                        self.recipesCollectionViewController?.collectionView?.activityIndicatorView.stopAnimating()
                        self.profileView.setNumberOfRecipes(number: recipes.count)
                    }
                }
        }
    }
    
    @objc func userChanged() {
        self.user = UserSession.sharedInstance.userSession
        profileView.user = user
        profileView.setInfos(user: user)
    }
}

extension ProfileViewController1: ProfileViewControllerDelegate {
    func didSelectRecipe(recipe: Recipe, category: String?) {
        let vc = RecipeViewController(recipe: recipe)
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
