//
//  Address.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Address: BackendPersistable {
    typealias AssociatedResource = AddressBackendResource
    var id: Int?
    var _type: BackendResourceType?
    var createdAt: Date?
    var updatedAt: Date?
    var primaryStreet: String
    var secondaryStreet: String?
    var state: String
    var zipcode: String
    var country: String
    var creatorID: Int

    init(primaryStreet: String, secondaryStreet: String? = nil, state:String, zipcode: String, country: String, creatorID: Int, id: Int? = nil, _type: BackendResourceType? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.primaryStreet = primaryStreet
        self.secondaryStreet = secondaryStreet
        self.state = state
        self.zipcode = zipcode
        self.country = country
        self.creatorID = creatorID
        self.id = id
        self._type = _type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
