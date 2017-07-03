//
//  CommentRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct CommentRequest: ServiceRequest {
    public typealias ReturnType = JSON
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    var parameters: [String : AnyObject] = [:]
    
    public init(recipeID: Int, userID: Int, data: String) {
        url = WebServiceConstant.baseUrl + "imc/public/api/comment"
        method = .post
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
        parameters = ["recipe_id":recipeID as AnyObject,
                      "user_id":userID as AnyObject,
                      "data": data as AnyObject]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(let value):
                if let value = value as? JSON {
                    resultHandler(value)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
