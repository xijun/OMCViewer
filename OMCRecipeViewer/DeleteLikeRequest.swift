//
//  DeleteLikeRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct DeleteLikeRequest: ServiceRequest {
    public typealias ReturnType = Void
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    var parameters: [String : AnyObject] = [:]
    
    public init(recipeID: Int, userID: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/deleteLike/\(recipeID)/\(userID)"
        method = .post
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(_):
                resultHandler()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
