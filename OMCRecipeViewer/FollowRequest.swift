//
//  FollowRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 22/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct FollowRequest: ServiceRequest {
    public typealias ReturnType = Void
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    var parameters: [String : AnyObject] = [:]
    
    public init(followerID: Int, userID: Int) {
        url = WebServiceConstant.baseUrl + "imc/public/api/follow"
        method = .post
        headers = ["Content-Type":"application/json",
                   "Authorization": "Bearer " + (UserSession.sharedInstance.userSession?.api_token)!]
        parameters = ["follower_id":followerID as AnyObject,
                      "user_id":userID as AnyObject]
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response { response in
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
