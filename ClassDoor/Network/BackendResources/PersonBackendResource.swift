//
//  PersonBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol PersonResourceClassifiable {
    var firstname: String? {get set}
    var lastname: String? {get set}
}

struct PersonBackendResource:  BackendPersistable, PersonResourceClassifiable {
    typealias ModelType = Person
    static var baseURLString: String {
        return "/persons"
    }
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String?
    var lastname: String?
    
    init() {}

    init(of person: Person) {
        self.set(with: person)
    }
    
    static func buildResource(with obj: Person) -> PersonBackendResource {
        var resource = PersonBackendResource()
        resource.set(with: obj)
        return resource
    }
    
    mutating func set(with person: Person) {
        self.id = person.id
        self.firstname = person.firstname
        self.lastname = person.lastname
        self.createdAt = person.createdAt
        self.updatedAt = person.updatedAt
    }
    
    init(firstname: String, lastname:String) {
        self.firstname = firstname
        self.lastname = lastname
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstname = "first_name"
        case lastname = "last_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decode(String.self, forKey: .lastname)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
    }
}
