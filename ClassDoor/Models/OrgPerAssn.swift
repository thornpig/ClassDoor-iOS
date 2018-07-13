//
//  OrgPerAssn.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/10/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct OrgPerAssn: BackendPersistable {
    typealias AssociatedResource = OrgPerAssnBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var organizationID: Int
    var associatedPersonID: Int
    var initiatorID: Int
    var terminated: Bool
    
    init(organizationID: Int, associatedPersonID: Int, initiatorID: Int, terminated: Bool, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.organizationID = organizationID
        self.associatedPersonID = associatedPersonID
        self.initiatorID = initiatorID
        self.terminated = terminated
    }
    
}
