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
    var modelObj: ModelType
//    var createdClasses: [Int]?
//    var createdOrganizations: [Int]?
//    var notificationDeliveries: [Int]?
//    var organizationAssociations: [Int]?
//    var visitingLessons: [Int]?


    init(of obj: ModelType) {
        self.modelObj = obj
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case _type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
        case username
        case password = "password_hash"
        case email
        case dependents
        case createdClasses = "created_classes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let passwordHash = try container.decodeIfPresent(String.self, forKey: .password)
        let username = try container.decode(String.self, forKey: .username)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        let firstname = try container.decodeIfPresent(String.self, forKey: .firstname)
        let lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        let dependentResources = try container.decodeIfPresent([DependentBackendResource].self, forKey: .dependents)
        let createdClassResources = try container.decodeIfPresent([ClassBackendResource].self, forKey: .createdClasses)
        self.modelObj = User(username: username,  email: email, firstname: firstname, lastname: lastname, passwordHash: passwordHash, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
        if let resources = dependentResources {
            self.modelObj.dependents = resources.map{$0.modelObj}
        }
        if let resources = createdClassResources {
            self.modelObj.createdClasses = resources.map{$0.modelObj}
        }
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.username, forKey: .username)
        try container.encodeIfPresent(self.modelObj.passwordHash, forKey: .password)
        try container.encodeIfPresent(self.modelObj.email, forKey: .email)
        try container.encodeIfPresent(self.modelObj.firstname, forKey: .firstname)
        try container.encodeIfPresent(self.modelObj.lastname, forKey: .lastname)
//        if let dps = self.modelObj.dependents {
//            try container.encode(dps.map{DependentBackendResource(of: $0)}, forKey: .dependents)
//        }
    }
}
