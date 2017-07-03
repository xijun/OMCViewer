//
//  RecipeDescriptionViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

public class RecipeDescriptionViewController: UIViewController {
    
    var recipe: Recipe
    var recipeDescriptionView: RecipeDescriptionView1
    
    init(recipe: Recipe) {
        self.recipe = recipe
        recipeDescriptionView = RecipeDescriptionView1.instantiate()
        super.init(nibName: nil,bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeDescriptionView.recipeDescription.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        recipeDescriptionView.setValues(description: recipe.description)
        self.view.addSubview(recipeDescriptionView)
        recipeDescriptionView.autoPinEdgesToSuperviewEdges()
    }
    
}
