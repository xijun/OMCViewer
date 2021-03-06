//
//  RecipesByTagRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public struct RecipesByTagRequest: ServiceRequest {
    public typealias ReturnType = [Recipe]
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String : AnyObject] = [:]
    
    public init(tag: String) {
        url = WebServiceConstant.baseUrl + "imc/public/api/recipes/tag/\(tag)"
        method = .get
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(let value):
                if let value = value as? [JSON] {
                    do {
                        let object: ReturnType = try value.map({try unbox(dictionary: $0)})
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
            }        }
        
    }
}
