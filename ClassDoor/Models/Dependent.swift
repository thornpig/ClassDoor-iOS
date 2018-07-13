//
//  Dependent.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Dependent: BackendPersistable, PersonClassifiable {
    typealias AssociatedResource = DependentBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var dependencyID: Int
    var enrollments: [Enrollment]?

    init(firstname: String, lastname: String, dependencyID: Int, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstname = firstname
        self.lastname = lastname
        self.dependencyID = dependencyID
    }
    
}
