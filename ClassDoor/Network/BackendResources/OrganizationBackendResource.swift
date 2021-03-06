//
//  OrganizationBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct OrganizationBackendResource: BackendResource {
    typealias ModelType = Organization
    static var baseURLString: String {
        return "/organizations"
    }
    var modelObj: Organization
    
    init(of obj: ModelType) {
        self.modelObj = obj
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case _type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name
        case creatorID = "creator_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let creatorID = try container.decode(Int.self, forKey: .creatorID)
        let name = try container.decode(String.self, forKey: .name)
        self.modelObj = Organization(name: name, creatorID: creatorID, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.creatorID, forKey: .creatorID)
        try container.encode(self.modelObj.name, forKey: .name)
    }
}
