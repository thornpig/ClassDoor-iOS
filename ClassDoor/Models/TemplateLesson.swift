//
//  TemplateLesson.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct TemplateLesson: BackendPersistable {
    typealias AssociatedResource = TemplateLessonBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var timeslotID: Int
    var classSessionID: Int
    var locationID: Int?

    init(timeslotID: Int, classSessionID: Int, locationID: Int? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.timeslotID = timeslotID
        self.classSessionID = classSessionID
        self.locationID = locationID
    }
}
