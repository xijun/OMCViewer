//
//  CommentRecipeRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct CommentRecipeRequest: ServiceRequest {
    public typealias ReturnType = Comment
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    var parameters: [String : AnyObject] = [:]
    
    public init(userID: Int, recipeID: Int, data: String) {
        url = WebServiceConstant.baseUrl + "imc/public/api/comment"
        method = .post
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
        parameters = ["user_id":userID as AnyObject,
                      "recipe_id":recipeID as AnyObject,
                      "data": data as AnyObject]
    }
    
}
