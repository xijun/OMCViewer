//
//  Ingredient.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 21/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Unbox

public struct Ingredient {
    let id: Int
    let name: String
    let description: String
    let unit: String
}

extension Ingredient: Unboxable {
    
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.description = try unboxer.unbox(key: "description")
        self.unit = try unboxer.unbox(key: "unit")
    }
}
