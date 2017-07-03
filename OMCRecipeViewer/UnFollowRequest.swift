//
//  UnFollowRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct UnFollowRequest: ServiceRequest {
    public typealias ReturnType = Void
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String : AnyObject] = [:]
    
    public init(followerID: Int, userID: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/unfollow/\(userID)/\(followerID)"
        method = .delete
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default, headers: headers).response { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    resultHandler()
                default:
                    print("error")
                }
            } else {
                print("error")
            }
        }
        
    }
}
