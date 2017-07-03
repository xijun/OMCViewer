//
//  UserRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public struct UserRequest: ServiceRequest {
    public typealias ReturnType = User
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String : AnyObject] = [:]
    
    public init(userID: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/users/id/\(userID)"
        method = .get
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result
            {
            case .success(let value):
                if let value = value as? JSON {
                    do {
                        let object: ReturnType = try unbox(dictionary: value)
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
