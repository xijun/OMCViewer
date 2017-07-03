//
//  NibLoadableView.swift
//  RecipeViewer
//
//  Created by Yves Yang on 26/02/2017.
//  Copyright © 2017 Yves Yang. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}
