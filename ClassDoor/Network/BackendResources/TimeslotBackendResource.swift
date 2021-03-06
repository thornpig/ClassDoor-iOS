//
//  TimeSlotBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/10/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct TimeslotBackendResource: BackendResource {
    typealias ModelType = Timeslot
    static var baseURLString: String {
        return "/timeslots"
    }
    var modelObj: ModelType
    
    init(of obj: ModelType) {
        self.modelObj = obj
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case _type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case startAt  = "start_at"
        case duration
        case scheduleID = "schedule_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let scheduleID = try container.decodeIfPresent(Int.self, forKey: .scheduleID)
        let startAt = try container.decode(Date.self, forKey: .startAt)
        let duration = try container.decode(Int.self, forKey: .duration)
        self.modelObj = Timeslot(startAt: startAt, duration: duration, scheduleID: scheduleID, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.modelObj.scheduleID, forKey: .scheduleID)
        try container.encode(self.modelObj.startAt, forKey: .startAt)
        try container.encode(self.modelObj.duration, forKey: .duration)
    }

}
