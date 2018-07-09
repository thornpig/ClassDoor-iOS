//
//  Dependent.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

class Dependent: Person, BackendPersistable {
    
    static let baseURLString = "/dependents"
    var dependencyID: Int
    
    init(firstname: String, lastname: String, dependencyID: Int) {
        self.dependencyID = dependencyID
        super.init(firstname: firstname, lastname: lastname)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
        case dependencyID = "dependency_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let firstname = try container.decode(String.self, forKey: .firstname)
        let lastname = try container.decode(String.self, forKey: .lastname)
        self.dependencyID = try container.decode(Int.self, forKey: .dependencyID)
        
        super.init(firstname: firstname, lastname: lastname)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
        try container.encode(self.dependencyID, forKey: .dependencyID)
    }
}
