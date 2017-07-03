//
//  LoginRequest.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct LoginRequest: ServiceRequest {
    typealias ReturnType = User
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: [String: AnyObject]
    
    public init(login: String, password: String) {
        url = WebServiceConstant.baseUrl + "imc/public/api/log"
        method = .post
        headers = ["Content-Type":"application/json"]
        parameters = ["username": login as AnyObject,
                      "password": password as AnyObject]
        
    }
    
}
