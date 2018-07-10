//
//  User.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct User: BackendResourceAssociated,  PersonClassifiable {
    typealias AssociatedResource = UserBackendResource
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var username: String
    var passwordHash: String
    var email: String
    lazy var backendResource = UserBackendResource(of: self)

    init(username: String, passwordHash: String, email: String, firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.passwordHash = passwordHash
        self.email = email
    }
    
    init(with resource: UserBackendResource) {
        self.init(username: resource.username!, passwordHash: resource.passwordHash!, email: resource.email!, firstname: resource.firstname!, lastname: resource.lastname!)
        self.id = resource.id
        self.createdAt = resource.createdAt
        self.updatedAt = resource.updatedAt
        self.backendResource = resource
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
