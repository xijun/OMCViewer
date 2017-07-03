//
//  ProfileInfosView1.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import UIKit

class ProfileInfosView1: UIView, NibLoadableView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    weak var delegate: ProfileInfosViewControllerDelegate?
    
    @IBAction func didPushEditButton() {
        self.delegate?.didPushEdit()
    }
    
    @IBAction func didPushLogOutButton() {
        self.delegate?.didPushLogOut()
    }
    
    static func instantiate() -> ProfileInfosView1 {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! ProfileInfosView1
    }
}
