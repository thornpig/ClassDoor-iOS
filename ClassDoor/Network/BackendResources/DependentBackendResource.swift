//
//  DependentBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct DependentBackendResource: BackendResource {
    typealias ModelType = Dependent
    static var baseURLString: String {
        return "/dependents"
    }
    
    var modelObj: Dependent

    init(of dependent: Dependent) {
        self.modelObj = dependent
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
        let id = try container.decode(Int.self, forKey: .id)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let firstname = try container.decode(String.self, forKey: .firstname)
        let lastname = try container.decode(String.self, forKey: .lastname)
        let dependencyID = try container.decode(Int.self, forKey: .dependencyID)
        self.modelObj = Dependent(firstname: firstname, lastname: lastname, dependencyID: dependencyID)
        self.modelObj.id = id
        self.modelObj.createdAt = createdAt
        self.modelObj.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.id, forKey: .id)
        try container.encode(self.modelObj.createdAt, forKey: .createdAt)
        try container.encode(self.modelObj.updatedAt, forKey: .updatedAt)
        try container.encode(self.modelObj.firstname, forKey: .firstname)
        try container.encode(self.modelObj.lastname, forKey: .lastname)
        try container.encode(self.modelObj.dependencyID, forKey: .dependencyID)
    }
}
