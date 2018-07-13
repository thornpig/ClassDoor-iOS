//
//  ClassSession.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct ClassSession: BackendPersistable {
    
    typealias AssociatedResource = ClassSessionBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var classID: Int
    var creatorID: Int
    var scheduleID: Int
    var capacity: Int?
    var schedule: Schedule?
    var enrollments: [Enrollment]?

    init(classID: Int, creatorID: Int, scheduleID: Int, capacity: Int? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.classID = classID
        self.creatorID = creatorID
        self.scheduleID = scheduleID
        self.capacity = capacity
    }
    
}
