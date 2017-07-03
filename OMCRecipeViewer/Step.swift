//
//  Step.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Unbox

public struct Step {
    let id: Int
    let description: String
    let order: Int
    let difficulty: Int
    let duration: Int
    let ingredients: [Ingredient]
}

extension Step: Unboxable {
    
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key:"id")
        self.description = try unboxer.unbox(key: "description")
        self.order = try unboxer.unbox(key: "order")
        self.difficulty = try unboxer.unbox(key: "difficulty")
        self.duration = try unboxer.unbox(key: "duration")
        self.ingredients = try unboxer.unbox(key: "ingredients")
    }
}
