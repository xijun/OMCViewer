//
//  CommentTableViewCell.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var user: UILabel!
}
