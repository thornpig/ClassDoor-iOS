//
//  DependentBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct DependentBackendResource: BackendPersistable, PersonResourceClassifiable {
    typealias ModelType = Dependent
    static var baseURLString: String {
        return "/dependents"
    }
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String?
    var lastname: String?
    var dependencyID: Int?
    
    init() {}
    
    init(of dependent: Dependent) {
        self.set(with: dependent)
    }
    
    static func buildResource(with obj: Dependent) -> DependentBackendResource{
        var resource = DependentBackendResource()
        resource.set(with: obj)
        return resource
    }
    
    mutating func set(with dependent: Dependent) {
        self.id = dependent.id
        self.createdAt = dependent.createdAt
        self.updatedAt = dependent.updatedAt
        self.firstname = dependent.firstname
        self.lastname = dependent.lastname
        self.dependencyID = dependent.dependencyID
    }

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
        case dependencyID = "dependency_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decode(String.self, forKey: .lastname)
        self.dependencyID = try container.decodeIfPresent(Int.self, forKey: .dependencyID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
        try container.encode(self.dependencyID, forKey: .dependencyID)
    }
}
