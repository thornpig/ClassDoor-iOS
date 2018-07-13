//
//  NotifDeliveryBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/11/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct NotifDeliveryBackendResource: BackendResource {
    typealias ModelType = NotifDelivery
    static var baseURLString: String {
        return "/notif-deliveries"
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
        case notificationID = "notification_id"
        case receiverID = "receiver_id"
        case deliveredAt = "delivered_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let notificationID = try container.decode(Int.self, forKey: .notificationID)
        let receiverID = try container.decode(Int.self, forKey: .receiverID)
        let deliveredAt = try container.decodeIfPresent(Date.self, forKey: .deliveredAt)
        self.modelObj = NotifDelivery(notificationID: notificationID, receiverID: receiverID, deliveredAt: deliveredAt, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.notificationID, forKey: .notificationID)
        try container.encode(self.modelObj.receiverID, forKey: .receiverID)
        try container.encodeIfPresent(self.modelObj.deliveredAt, forKey: .deliveredAt)
    }
}
