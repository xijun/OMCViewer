//
//  ImageViewExtension.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 16/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = URL(string: url) {
            do {
                let data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            }
            catch {
                //display a default image
            }
        }
    }
}
