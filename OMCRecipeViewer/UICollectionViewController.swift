//
//  UICollectionViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewController {
    
    func showNoContents(msg: String) {
        guard let collectionView = self.collectionView else { return }
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        noDataLabel.text          = msg
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        collectionView.backgroundView  = noDataLabel
    }
}
