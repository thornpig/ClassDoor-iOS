//
//  RepeatedLesson.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct RepeatedLesson: BackendPersistable, LessonClassifiable {
    typealias AssociatedResource = RepeatedLessonBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var classSessionID: Int
    var templateLessonID: Int
    var indexOfRep: Int
    var startAt: Date?
    var duration: Int?

    init(classSessionID: Int, templateLessonID: Int, indexOfRep: Int, startAt: Date? = nil, duration: Int? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.classSessionID = classSessionID
        self.templateLessonID = templateLessonID
        self.indexOfRep = indexOfRep
        self.startAt = startAt
        self.duration = duration
    }
}
