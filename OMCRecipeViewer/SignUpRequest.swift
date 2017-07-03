//
//  SignUpRequest.swift
//  OMCRecipeViewer
//
//  Created by Yves Yang on 28/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire

public struct SignUpRequest: ServiceRequest {
    public typealias ReturnType = Void
    
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    var parameters: [String : AnyObject] = [:]
    
    public init(values: JSON) {
        url = WebServiceConstant.baseUrl + "imc/public/api/signup"
        method = .post
        headers = ["Content-Type":"application/json"]
        parameters = values
    }
    
    public func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
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
