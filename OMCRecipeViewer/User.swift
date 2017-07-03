//
//  User.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import Unbox


public struct User {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let country: String
    let age: String
    let sexe: String
    let api_token: String?
    
    static func encode(user: User) {
        let userContent = UserContent(user: user)
        let data = NSKeyedArchiver.archivedData(withRootObject: userContent)
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "user")
        userDefaults.synchronize()
    }
    
    static func decode() -> User? {
        let userDefaults = UserDefaults.standard
        guard let data  = userDefaults.object(forKey: "user") as? Data else {
            return nil
        }
        let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserContent
        return user?.user
    }
}

public class UserContent: NSObject, NSCoding {
    
    var user: User?
    
    init(user: User) {
        self.user = user
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int ?? aDecoder.decodeInteger(forKey: "id")
        let firstname = aDecoder.decodeObject(forKey: "firstname") as! String
        let lastname = aDecoder.decodeObject(forKey: "lastname") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let country = aDecoder.decodeObject(forKey: "country") as! String
        let age = aDecoder.decodeObject(forKey: "age") as! String
        let sexe = aDecoder.decodeObject(forKey: "sexe") as! String
        let api_token = aDecoder.decodeObject(forKey: "api_token") as! String
        
        user = User(id: id, firstname: firstname, lastname: lastname, email: email, country: country, age: age, sexe: sexe, api_token: api_token)
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(user?.id, forKey: "id")
        aCoder.encode(user?.firstname, forKey: "firstname")
        aCoder.encode(user?.lastname, forKey: "lastname")
        aCoder.encode(user?.email, forKey: "email")
        aCoder.encode(user?.country, forKey: "country")
        aCoder.encode(user?.age, forKey: "age")
        aCoder.encode(user?.sexe, forKey: "sexe")
        aCoder.encode(user?.api_token, forKey: "api_token")
    }
}

extension User: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.firstname = try unboxer.unbox(key: "firstname")
        self.lastname = try unboxer.unbox(key: "name")
        self.email = try unboxer.unbox(key: "email")
        self.country = try unboxer.unbox(key: "country")
        self.age = try unboxer.unbox(key: "age")
        self.sexe = try unboxer.unbox(key: "sexe")
        self.api_token = unboxer.unbox(key: "api_token")
    }
}
