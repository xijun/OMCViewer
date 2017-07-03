//
//  RecipesCollectionViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 16/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

class RecipesCollectionViewController: UICollectionViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            reloadData()
        }
    }
    
    var category: String?
    
    var setNavigation: Bool = false
    
    weak var profileViewControllerDelegate: ProfileViewControllerDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if setNavigation {
            setNavBar(title: category)
        }
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(RecipesCollectionViewCell.self)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let category = self.category, setNavigation else { return }
        loadRecipesByTag(category: category)
    }
    
    func loadRecipesByTag(category: String) {
        collectionView?.activityIndicatorView.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async {
            // Bounce back to the main thread to update the UI
            RecipesByTagRequest(tag: category).perform { result in
                DispatchQueue.main.async {
                    self.recipes = result
                    self.collectionView?.activityIndicatorView.stopAnimating()
                }
            }
        }

    }
    
    func reloadData() {
        collectionView?.reloadData()
        if recipes.count <= 0 {
            showNoContents(msg: "No available recipes")
            collectionView?.backgroundView?.isHidden = false
        } else {
            collectionView?.backgroundView?.isHidden = true
        }
    }
    
}

extension RecipesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> RecipesCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as RecipesCollectionViewCell
        let recipe = recipes[indexPath.row]
        if let url = recipe.imageUrl {
            cell.image.setImageFromURl(stringImageUrl: url)
        } else {
            cell.image.image = UIImage(named: "default_recipe")
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 4) / 3
        return CGSize(width: width, height: width)
    }
    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1, left: 1, bottom: (tabBarController?.tabBar.frame.height)!, right: 1)
//    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        profileViewControllerDelegate?.didSelectRecipe(recipe: recipe, category: category)
    }
}

