//
//  Person.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol PersonClassifiable {
//    var firstname: String {get set}
//    var lastname: String {get set}
    var id: Int? {get set}
    var enrollments: [Enrollment]? {get set}
}

struct Person: BackendPersistable, PersonClassifiable {
    typealias AssociatedResource = PersonBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var enrollments: [Enrollment]?

    init(firstname: String, lastname:String, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstname = firstname
        self.lastname = lastname
    }
    
}
