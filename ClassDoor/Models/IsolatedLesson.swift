//
//  Lesson.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol LessonClassifiable {
    var classSessionID: Int {get set}
}

struct IsolatedLesson: BackendPersistable, LessonClassifiable {
    typealias AssociatedResource = IsolatedLessonBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var classSessionID: Int
    var startAt: Date
    var duration: Int
    var locationID: Int?

    init(classSessionID: Int, startAt: Date, duration: Int, locationID: Int? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.classSessionID = classSessionID
        self.startAt = startAt
        self.duration = duration
        self.locationID = locationID
    }
}
