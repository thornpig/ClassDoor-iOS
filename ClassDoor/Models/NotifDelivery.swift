//
//  NotifDelivery.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/11/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct NotifDelivery: BackendPersistable {
    typealias AssociatedResource = NotifDeliveryBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var notificationID: Int
    var receiverID: Int
    var deliveredAt: Date?
    
    init(notificationID: Int, receiverID: Int, deliveredAt: Date? = nil, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.notificationID = notificationID
        self.receiverID = receiverID
        self.deliveredAt = deliveredAt
    }
    
}
