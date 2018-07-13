//
//  ScheduleBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct ScheduleBackendResource: BackendResource {
    typealias ModelType = Schedule
    static var baseURLString: String {
        return "/schedules"
    }
    var modelObj: Schedule
    
    init(of obj: ModelType) {
        self.modelObj = obj
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case _type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case repeatOption  = "repeat_option"
        case repeatEndAt = "repeat_end_at"
        case baseTimeslots = "base_time_slots"
        case repeatTimeslots = "repeat_time_slots"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let repeatOption = try container.decode(RepeatOption.self, forKey: .repeatOption)
        let repeatEndAt = try container.decode(Date.self, forKey: .repeatEndAt)
        let baseTimeslotResources = try container.decodeIfPresent([TimeslotBackendResource].self, forKey: .baseTimeslots)
        let repeatTimeslotResources = try container.decodeIfPresent([TimeslotBackendResource].self, forKey: .repeatTimeslots)
        self.modelObj = Schedule(repeatOption: repeatOption, repeatEndAt: repeatEndAt, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
        if let baseTSs = baseTimeslotResources {
            self.modelObj.baseTimeslots = baseTSs.map{$0.modelObj}
        }
        if let repeatTSs = repeatTimeslotResources {
            self.modelObj.repeatTimeslots = repeatTSs.map{$0.modelObj}
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.repeatOption, forKey: .repeatOption)
        try container.encodeIfPresent(self.modelObj.repeatEndAt, forKey: .repeatEndAt)
        if let baseTSs = self.modelObj.baseTimeslots {
            try container.encode(baseTSs.map{TimeslotBackendResource(of: $0)}, forKey: .baseTimeslots)
        }
        if let repeatTSs = self.modelObj.repeatTimeslots {
            try container.encode(repeatTSs.map{TimeslotBackendResource(of: $0)}, forKey: .repeatTimeslots)
        }
    }
    
    
}
