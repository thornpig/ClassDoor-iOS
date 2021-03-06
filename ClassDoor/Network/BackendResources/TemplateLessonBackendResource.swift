//
//  TemplateLessonBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct TemplateLessonBackendResource: BackendResource {
    typealias ModelType = TemplateLesson
    static var baseURLString: String {
        return "/template-lessons"
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
        case timeslotID = "time_slot_id"
        case classSessionID = "class_session_id"
        case locationID = "location_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let classSessionID = try container.decode(Int.self, forKey: .classSessionID)
        let timeslotID = try container.decode(Int.self, forKey: .timeslotID)
        let locationID = try container.decodeIfPresent(Int.self, forKey: .locationID)
        self.modelObj = TemplateLesson(timeslotID: timeslotID, classSessionID: classSessionID, locationID: locationID, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.classSessionID, forKey: .classSessionID)
        try container.encode(self.modelObj.timeslotID, forKey: .timeslotID)
        try container.encodeIfPresent(self.modelObj.locationID, forKey: .locationID)
    }
}
