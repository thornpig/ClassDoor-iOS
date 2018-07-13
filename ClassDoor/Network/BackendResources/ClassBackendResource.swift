//
//  ClassBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct ClassBackendResource: BackendResource {
    typealias ModelType = Class
    static var baseURLString: String {
        return "/classes"
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
        case senderID = "sender_id"
        case content
        case title
        case description
        case creatorID = "creator_id"
        case duration
        case organizationID = "organization_id"
        case numOfLessonsPerSession = "num_of_lessons_per_session"
        case capacity
        case minAge = "min_age"
        case maxAge = "max_age"
        case sessions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let creatorID = try container.decode(Int.self, forKey: .creatorID)
        let title = try container.decode(String.self, forKey: .title)
        let description = try container.decode(String.self, forKey: .description)
        let duration = try container.decode(Int.self, forKey: .duration)
        let orgID = try container.decodeIfPresent(Int.self, forKey: .organizationID)
        let numOfLPS = try container.decodeIfPresent(Int.self, forKey: .numOfLessonsPerSession)
        let capacity = try container.decodeIfPresent(Int.self, forKey: .capacity)
        let minAge = try container.decodeIfPresent(Int.self, forKey: .minAge)
        let maxAge = try container.decodeIfPresent(Int.self, forKey: .maxAge)
        let sessionResources = try container.decodeIfPresent([ClassSessionBackendResource].self, forKey: .sessions)
        self.modelObj = Class(title: title, description: description, creatorID: creatorID, duration: duration, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
        self.modelObj.organizationID = orgID
        self.modelObj.numOfLessonsPerSession = numOfLPS
        self.modelObj.capacity = capacity
        self.modelObj.minAge = minAge
        self.modelObj.maxAge = maxAge
        if let resources = sessionResources {
            self.modelObj.sessions = resources.map{$0.modelObj}
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.title, forKey: .title)
        try container.encode(self.modelObj.description, forKey: .description)
        try container.encode(self.modelObj.duration, forKey: .duration)
        try container.encode(self.modelObj.creatorID, forKey: .creatorID)
        try container.encodeIfPresent(self.modelObj.organizationID, forKey: .organizationID)
        try container.encodeIfPresent(self.modelObj.capacity, forKey: .capacity)
        try container.encodeIfPresent(self.modelObj.numOfLessonsPerSession, forKey: .numOfLessonsPerSession)
        try container.encodeIfPresent(self.modelObj.minAge, forKey: .minAge)
        try container.encodeIfPresent(self.modelObj.maxAge, forKey: .maxAge)
    }
}
