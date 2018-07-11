//
//  User.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct User: BackendPersistable,  PersonClassifiable {
    
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var username: String
    var passwordHash: String
    var email: String
    var dependents: [Dependent]?
    
//    lazy var backendResource = UserBackendResource(of: self)

    init(username: String, passwordHash: String, email: String, firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.passwordHash = passwordHash
        self.email = email
    }
    
    init(with resource: UserBackendResource) {
        let resourceObj = resource.modelObj
        self.init(username: resourceObj.username, passwordHash: resourceObj.passwordHash, email: resourceObj.email, firstname: resourceObj.firstname, lastname: resourceObj.lastname)
        self.id = resourceObj.id
        self.createdAt = resourceObj.createdAt
        self.updatedAt = resourceObj.updatedAt
    }
    
    static func validifyUsername(username: String) -> Bool {
        let letterCount  = username.count
        return (letterCount > 0) && (letterCount <= 20)
    }
    
    static func validifyPassword(password: String) -> Bool {
        let passCount = password.count
        return (passCount >= 6) && (passCount <= 20)
    }

}
