//
//  RecipeView.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 17/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

class RecipeView1: UIView, NibLoadableView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    weak var delegate: RecipeViewControllerDelegate?
    
    var recipe: Recipe? {
        didSet {
            if let url = recipe?.imageUrl {
                image.setImageFromURl(stringImageUrl: url)
            } else {
                image.image = UIImage(named: "default_recipe")
            }
            author.text = "\(String(describing: recipe!.user.firstname)) \(String(describing: recipe!.user.lastname))"
            recipeName.text = recipe?.name
            guard let user = recipe?.user,
                  let sessionID = UserSession.sharedInstance.userSession?.id else { return }
            likeButton.isEnabled = sessionID != user.id
            commentButton.isEnabled = sessionID != user.id
            guard let recipeID = recipe?.ID else { return }
            RecipeLikesRequest(recipeID: recipeID).perform { result in
                self.likeButton.isSelected = !result.filter({ $0.id == sessionID }).isEmpty
            }
            RecipeByIdRequest(id: recipeID).perform { result in
                self.comments = result
            }
        }
    }
    
    var comments: [Comment]? {
        didSet {
            commentButton.isEnabled = true
        }
    }
    
    static func instantiate() -> RecipeView1 {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        let recipeView = nib.instantiate(withOwner: self, options: nil).first as! RecipeView1
        return recipeView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(UIImage(named: "ic_like"), for: .normal)
        likeButton.setImage(UIImage(named: "ic_like")?.maskWithColor(color: UIColor.red), for: .selected)
        commentButton.setImage(UIImage(named: "ic_comment"), for: .normal)
        commentButton.setImage(UIImage(named: "ic_comment")?.maskWithColor(color: UIColor.red), for: .selected)
        commentButton.isEnabled = false
    }
    
    @objc func didTapAuthor() {
        delegate?.didTapAuthor()
    }
    
    public func setInfos(user: User) {
        if user.email != recipe?.user.email {
            author.textColor = UIColor.blue
            author.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAuthor)))
            author.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func didTapLikeButton() {
        guard let recipeID = self.recipe?.ID,
            let userID = UserSession.sharedInstance.userSession?.id else { return }
        let initial = likeButton.isSelected
        self.likeButton.isSelected = !initial
        if initial {
            RecipeUnlikeRequest(recipeID: recipeID, userID: userID).perform { isValid in
                if !isValid {
                    self.likeButton.isSelected = initial
                }
            }
        } else {
            RecipeLikeRequest(recipeID: recipeID, userID: userID).perform { isValid in
                if !isValid {
                    self.likeButton.isSelected = initial
                }
            }
        }
    }
    @IBAction func didTapCommentButton() {
        delegate?.didTapComment(comments: comments ?? [])
    }
}
