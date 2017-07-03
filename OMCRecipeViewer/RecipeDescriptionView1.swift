//
//  RecipeDescriptionView.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

class RecipeDescriptionView1: UIView, NibLoadableView {
    
    @IBOutlet weak var recipeDescription: UITextView!
    
    static func instantiate() -> RecipeDescriptionView1 {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! RecipeDescriptionView1
    }
    
    func setValues(description: String) {
        recipeDescription.text = description
    }
    
}
