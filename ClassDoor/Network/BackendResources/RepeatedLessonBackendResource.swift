//
//  RepeatedLessonBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct RepeatedLessonBackendResource: BackendResource {
    typealias ModelType = RepeatedLesson
    static var baseURLString: String {
        return "/repeated-lessons"
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
        case classSessionID = "class_session_id"
        case templateLessonID = "template_lesson_id"
        case indexOfRep = "index_of_rep"
        case startAt = "start_at"
        case duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let classSessionID = try container.decode(Int.self, forKey: .classSessionID)
        let templateLessonID = try container.decode(Int.self, forKey: .templateLessonID)
        let indexOfRep = try container.decode(Int.self, forKey: .indexOfRep)
        let startAt = try container.decodeIfPresent(Date.self, forKey: .startAt)
        let duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.modelObj = RepeatedLesson(classSessionID: classSessionID, templateLessonID: templateLessonID, indexOfRep: indexOfRep, startAt: startAt, duration: duration, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.classSessionID, forKey: .classSessionID)
        try container.encode(self.modelObj.templateLessonID, forKey: .templateLessonID)
        try container.encode(self.modelObj.indexOfRep, forKey: .indexOfRep)
        try container.encodeIfPresent(self.modelObj.startAt, forKey: .startAt)
        try container.encodeIfPresent(self.modelObj.duration, forKey: .duration)
    }
}
