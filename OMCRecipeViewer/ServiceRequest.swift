//
//  ServiceRequest.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

protocol ServiceRequest {
    
    associatedtype ReturnType
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: AnyObject] { get }
    
    func perform(resultHandler: @escaping (ReturnType) -> Void)
}


extension ServiceRequest where ReturnType: Unboxable {
    func perform(resultHandler: @escaping (ReturnType) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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
            case .failure:
                break
            }
        }
    }
}
