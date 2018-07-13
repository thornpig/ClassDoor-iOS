//
//  OrgPerAssnBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/10/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct OrgPerAssnBackendResource: BackendResource {
    typealias ModelType = OrgPerAssn
    static var baseURLString: String {
        return "/org-per-assns"
    }
    var modelObj: OrgPerAssn
    
    init(of obj: ModelType) {
        self.modelObj = obj
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case _type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case organizationID = "organization_id"
        case associatedPersonID = "associated_person_id"
        case initiatorID = "initiator_id"
        case terminated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let organizationID = try container.decode(Int.self, forKey: .organizationID)
        let initiatorID = try container.decode(Int.self, forKey: .initiatorID)
        let associatedPersonID = try container.decode(Int.self, forKey: .associatedPersonID)
        let terminated = try container.decode(Bool.self, forKey: .terminated)
        self.modelObj = OrgPerAssn(organizationID: organizationID, associatedPersonID: associatedPersonID, initiatorID: initiatorID, terminated: terminated, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.organizationID, forKey: .organizationID)
        try container.encode(self.modelObj.associatedPersonID, forKey: .associatedPersonID)
        try container.encode(self.modelObj.initiatorID, forKey: .initiatorID)
        try container.encode(self.modelObj.terminated, forKey: .terminated)
    }
}
