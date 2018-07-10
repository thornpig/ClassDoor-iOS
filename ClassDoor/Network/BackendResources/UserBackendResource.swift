//
//  UserBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct UserBackendResource: BackendPersistable, PersonResourceClassifiable {

    typealias ModelType = User
    static var baseURLString: String {
        return "/users"
    }
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var username: String?
    var passwordHash: String?
    var email: String?
    var firstname: String?
    var lastname: String?
    var dependents: [DependentBackendResource]?
//    var createdClasses: [Int]?
//    var createdOrganizations: [Int]?
//    var notificationDeliveries: [Int]?
//    var organizationAssociations: [Int]?
//    var visitingLessons: [Int]?

    init() {}
    
    init(of user: User) {
        self.set(with: user)
    }
    
    static func buildResource(with obj: User) -> UserBackendResource {
        var resource = UserBackendResource()
        resource.set(with: obj)
        return resource
    }
    
    mutating func set(with user: User) {
        self.id = user.id
        self.createdAt = user.createdAt
        self.updatedAt = user.updatedAt
        self.username = user.username
        self.passwordHash = user.passwordHash
        self.email = user.email
        self.firstname = user.firstname
        self.lastname = user.lastname
    }
    
    init(username: String, passwordHash: String, email: String, firstname: String, lastname: String) {
        self.username = username
        self.passwordHash = passwordHash
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
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
        self.id = try container.decode(Int.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.passwordHash = "abcdefgh"
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.dependents = try container.decode([DependentBackendResource].self, forKey: .dependents)
        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decode(String.self, forKey: .lastname)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.username, forKey: .username)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
        try container.encode(self.dependents, forKey: .dependents)
    }
}
