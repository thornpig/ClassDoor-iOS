//
//  User.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct User: BackendPersistable,  PersonClassifiable {
    typealias AssociatedResource = UserBackendResource
    
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String?
    var lastname: String?
    var username: String
    var passwordHash: String?
    var email: String?
    var dependents: [Dependent]?
    var createdClasses: [Class]?
    var enrollments: [Enrollment]?
    
    init(username: String,  email: String? = nil, firstname: String? = nil, lastname: String? = nil, passwordHash: String? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.passwordHash = passwordHash
        self.email = email
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
