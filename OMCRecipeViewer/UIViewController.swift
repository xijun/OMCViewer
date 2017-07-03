//
//  UIViewController.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 18/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavBar(title: String?) {
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_left_arrow"), style: .plain, target: self, action: #selector(rewind))
        if let title = title {
            self.navigationItem.title = title
        }
    }
    
    @objc func dismissVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func rewind() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
