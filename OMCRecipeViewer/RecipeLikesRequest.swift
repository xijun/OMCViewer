//
//  RecipeLikesRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public struct RecipeLikesRequest: ServiceRequest {
    typealias ReturnType = [User]
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String : AnyObject] = [:]
    
    public init(recipeID: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/likes/\(recipeID)"
        method = .get
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    public func perform(resultHandler: @escaping ([User]) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(let value):
                if let value = value as? [JSON] {
                    do {
                        let object: ReturnType = try value.map({try unbox(dictionary: $0["user"] as! UnboxableDictionary)})
                        resultHandler(object)
                    }
                    catch {
                        print("error in parsing object")
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
