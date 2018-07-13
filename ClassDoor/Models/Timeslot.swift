//
//  Timeslot.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/10/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Timeslot: BackendPersistable {
    typealias AssociatedResource = TimeslotBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var startAt: Date
    var duration: Int
    var scheduleID: Int?
    
    init(startAt: Date, duration: Int, scheduleID: Int? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.startAt = startAt
        self.duration  = duration
        self.scheduleID = scheduleID
    }
}
