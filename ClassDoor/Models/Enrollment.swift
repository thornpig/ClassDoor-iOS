//
//  Enrollment.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Enrollment: BackendPersistable {
    
    typealias AssociatedResource = EnrollmentBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var classSessionID: Int
    var enrolledPersonID: Int
    var initiatorID: Int
    var terminated: Bool
    var classSession: ClassSession?
    
    init(classSessionID: Int,  enrolledPersonID: Int, initiatorID: Int, terminated: Bool, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.classSessionID = classSessionID
        self.enrolledPersonID = enrolledPersonID
        self.initiatorID = initiatorID
        self.terminated = terminated
    }
    
}
