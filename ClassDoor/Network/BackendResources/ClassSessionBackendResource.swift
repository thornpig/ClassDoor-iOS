//
//  ClassSessionBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct ClassSessionBackendResource: BackendResource {
    typealias ModelType = ClassSession
    static var baseURLString: String {
        return "/class-sessions"
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
        case classID = "class_id"
        case creatorID = "creator_id"
        case scheduleID = "schedule_id"
        case capacity
        case enrollments
        case schedule
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let classID = try container.decode(Int.self, forKey: .classID)
        let creatorID = try container.decode(Int.self, forKey: .creatorID)
        let scheduleID = try container.decode(Int.self, forKey: .scheduleID)
        let capacity = try container.decodeIfPresent(Int.self, forKey: .capacity)
        let schedule = try container.decodeIfPresent(ScheduleBackendResource.self, forKey: .schedule)
        let enrollmentResources = try container.decodeIfPresent([EnrollmentBackendResource].self, forKey: .enrollments)
        self.modelObj = ClassSession(classID: classID, creatorID: creatorID, scheduleID: scheduleID, capacity: capacity, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
        self.modelObj.schedule = schedule?.modelObj
        if let resources = enrollmentResources {
            self.modelObj.enrollments = resources.map{$0.modelObj}
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.classID, forKey: .classID)
        try container.encode(self.modelObj.creatorID, forKey: .creatorID)
        try container.encode(self.modelObj.scheduleID, forKey: .scheduleID)
        try container.encodeIfPresent(self.modelObj.capacity, forKey: .capacity)
    }
}
