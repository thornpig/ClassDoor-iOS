//
//  Notification.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Notification: BackendPersistable {
    
    typealias AssociatedResource = NotificationBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var senderID: Int
    var content: String

    init(senderID: Int, content: String, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.senderID = senderID
        self.content = content
    }
    
}
