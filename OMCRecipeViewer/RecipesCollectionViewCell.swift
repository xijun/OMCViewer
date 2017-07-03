//
//  RecipesCollectionViewCell.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 16/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

public class RecipesCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    
    @IBOutlet weak var image: UIImageView!
    
    override public func prepareForReuse() {
        
    }
}
