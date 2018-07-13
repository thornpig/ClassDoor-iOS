//
//  Schedule.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

enum RepeatOption: String, Codable {
    case NEVER = "RepeatOption.NEVER"
    case DAILY = "RepeatOption.DAILY"
    case WEELY = "RepeatOption.WEEKLY"
    case BIWEEKLY = "RepeatOption.BIWEEKLY"
    case MONTHLY = "RepeatOption.MONTHLY"
    case YEARLY = "RepeatOption.YEARLY"
    case SPECIFIC = "RepeatOption.SPECIFIC"
    
    static var allValues: [RepeatOption] {
        return [RepeatOption.NEVER, RepeatOption.DAILY, RepeatOption.WEELY, RepeatOption.BIWEEKLY, RepeatOption.MONTHLY, RepeatOption.YEARLY, RepeatOption.SPECIFIC]
    }
}

struct Schedule: BackendPersistable {
    typealias AssociatedResource = ScheduleBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var repeatOption: RepeatOption
    var repeatEndAt: Date?
    var baseTimeslots: [Timeslot]?
    var repeatTimeslots: [Timeslot]?
    
    init(repeatOption: RepeatOption, repeatEndAt: Date? = nil, baseTimeslots: [Timeslot]? = nil, repeatTimeslots: [Timeslot]? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.repeatEndAt = repeatEndAt
        self.repeatOption = repeatOption
        self.baseTimeslots = baseTimeslots
        self.repeatTimeslots = repeatTimeslots
    }
}
