//
//  Comment.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 27/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Unbox


public struct Comment {
    let id: Int
    let recipeID: Int
    let user: User
    let data: String
    let creation_date: Date
}

extension Comment: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.recipeID = try unboxer.unbox(key: "recipe_id")
        self.user = try unboxer.unbox(key: "user")
        self.data = try unboxer.unbox(key: "data")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        self.creation_date = try unboxer.unbox(key: "creation_date", formatter: dateFormatter)
    }
}
