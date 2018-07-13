//
//  EnrollmentBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct EnrollmentBackendResource: BackendResource {
    typealias ModelType = Enrollment
    static var baseURLString: String {
        return "/enrollments"
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
        case enrolledPersonID = "enrolled_person_id"
        case initiatorID = "initiator_id"
        case terminated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let classSessionID = try container.decode(Int.self, forKey: .classSessionID)
        let enrolledPersonID = try container.decode(Int.self, forKey: .enrolledPersonID)
        let initiatorID = try container.decode(Int.self, forKey: .initiatorID)
        let terminated = try container.decode(Bool.self, forKey: .terminated)
        self.modelObj = Enrollment(classSessionID: classSessionID, enrolledPersonID: enrolledPersonID, initiatorID: initiatorID, terminated: terminated, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.classSessionID, forKey: .classSessionID)
        try container.encode(self.modelObj.enrolledPersonID, forKey: .enrolledPersonID)
        try container.encode(self.modelObj.initiatorID, forKey: .initiatorID)
        try container.encode(self.modelObj.terminated, forKey: .terminated)
    }
}
