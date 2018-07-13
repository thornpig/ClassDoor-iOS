//
//  Class.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Class: BackendPersistable {
    
    typealias AssociatedResource = ClassBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var title: String
    var description: String
    var creatorID: Int
    var duration: Int
    var organizationID: Int?
    var numOfLessonsPerSession: Int?
    var capacity: Int?
    var minAge: Int?
    var maxAge: Int?
    var sessions: [ClassSession]?
    
    init(title: String, description: String, creatorID: Int, duration: Int, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.title = title
        self.description = description
        self.creatorID = creatorID
        self.duration = duration
    }
    
}
