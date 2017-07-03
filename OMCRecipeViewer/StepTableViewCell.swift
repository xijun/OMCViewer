//
//  StepTableViewCell.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var stepDescription: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var ingredients: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
