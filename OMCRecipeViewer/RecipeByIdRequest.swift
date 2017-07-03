//
//  RecipeByIdRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 27/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public struct RecipeByIdRequest: ServiceRequest {
    public typealias ReturnType = [Comment]
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String : AnyObject] = [:]
    
    public init(id: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/recipes/id/\(id)"
        method = .get
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(let value):
                if let value = value as? JSON {
                    if let comments = value["comments"] as? [JSON] {
                        do {
                            let object: ReturnType = try comments.map({try unbox(dictionary: $0)})
                            resultHandler(object)
                        }
                        catch {
                            print("error in parsing object")
                        }
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
