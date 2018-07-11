//
//  UserBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct UserBackendResource: BackendResource {
    typealias ModelType = User
    
    static var baseURLString: String {
        return "/users"
    }
    var modelObj: User
//    var createdClasses: [Int]?
//    var createdOrganizations: [Int]?
//    var notificationDeliveries: [Int]?
//    var organizationAssociations: [Int]?
//    var visitingLessons: [Int]?


    init(of user: User) {
        self.modelObj = user
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
        case username
        case email
        case dependents
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let passwordHash = "abcdefgh"
        let username = try container.decode(String.self, forKey: .username)
        let email = try container.decode(String.self, forKey: .email)
        let dependentResources = try container.decodeIfPresent([DependentBackendResource].self, forKey: .dependents)
        let firstname = try container.decode(String.self, forKey: .firstname)
        let lastname = try container.decode(String.self, forKey: .lastname)
        self.modelObj = User(username: username, passwordHash: passwordHash, email: email, firstname: firstname, lastname: lastname)
        self.modelObj.id = id
        self.modelObj.createdAt = createdAt
        self.modelObj.updatedAt = updatedAt
        if let resources = dependentResources {
            self.modelObj.dependents = resources.map{$0.modelObj}
        }
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.username, forKey: .username)
        try container.encode(self.modelObj.email, forKey: .email)
        try container.encode(self.modelObj.firstname, forKey: .firstname)
        try container.encode(self.modelObj.lastname, forKey: .lastname)
        if let dps = self.modelObj.dependents {
            try container.encode(dps.map{DependentBackendResource(of: $0)}, forKey: .dependents)
        }
    }
}
