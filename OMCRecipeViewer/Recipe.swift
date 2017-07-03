//
//  Recipe.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 16/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Unbox

public struct Recipe {
    
    let ID: Int
    let name: String
    let creation_date: Date
    let description: String
    let imageUrl: String?
    let user: User
    let steps: [Step]

}

extension Recipe: Unboxable {
    
    public init(unboxer: Unboxer) throws {
        self.ID = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        self.creation_date = try unboxer.unbox(key: "creation_date", formatter: dateFormatter)
        self.description = try unboxer.unbox(key: "description")
        self.user = try unboxer.unbox(key: "user")
        self.imageUrl = unboxer.unbox(key: "imageUrl")
        self.steps = try unboxer.unbox(key: "steps")
    }
    
}
