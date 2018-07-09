//
//  User.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

class User: Person, BackendPersistable {
    static let baseURLString = "/users"

    var username: String
    var passwordHash: String
    var email: String
    var dependentIDs: [Int] = []
    var createdClassIDs: [Int] = []
    var createdOrganizationIDs: [Int] = []
    var notificationDeliveryIDs: [Int] = []
    var organizationAssociationIDs: [Int] = []
    var visitingLessonIDs: [Int] = []
    
    init(username: String, passwordHash: String, email: String, firstname: String, lastname: String) {
        self.username = username
        self.passwordHash = passwordHash
        self.email = email
        super.init(firstname: firstname, lastname: lastname)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
        case username
        case email
    }
    required  init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.passwordHash = "abcdefgh"
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        let firstname = try container.decode(String.self, forKey: .firstname)
        let lastname = try container.decode(String.self, forKey: .lastname)
        super.init(firstname: firstname, lastname: lastname)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.username, forKey: .username)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
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
