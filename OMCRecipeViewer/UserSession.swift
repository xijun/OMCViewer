//
//  UserSession.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation

class UserSession {
    static let sharedInstance: UserSession = UserSession()
    
    private var user: User? = User.decode()
    
    var userSession: User? {
        get {
            if (user == nil) {
                user = User.decode()
                return user
            }
            else {
                return user
            }
        }
        set {
            guard let newUser = newValue else {
                return
            }
            User.encode(user: newUser)
            user = newValue
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userChanged"), object: self)
        }
    }
    
    class func logOut() {
        UserDefaults.standard.removeObject(forKey: "user")
    }

}
