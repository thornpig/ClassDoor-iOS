//
//  AddressBackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct AddressBackendResource: BackendResource {
    typealias ModelType = Address
    static var baseURLString: String {
        return "/addresses"
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
        case primaryStreet  = "primary_street"
        case secondaryStreet  = "secondary_street"
        case state
        case zipcode
        case country
        case creatorID = "creator_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let _type = try container.decode(BackendResourceType.self, forKey: ._type)
        let createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        let updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        let primaryStreet = try container.decode(String.self, forKey: .primaryStreet)
        let secondaryStreet = try container.decodeIfPresent(String.self, forKey: .secondaryStreet)
        let state = try container.decode(String.self, forKey: .state)
        let zipcode = try container.decode(String.self, forKey: .zipcode)
        let country = try container.decode(String.self, forKey: .country)
        let creatorID = try container.decode(Int.self, forKey: .creatorID)
        self.modelObj = Address(primaryStreet: primaryStreet, secondaryStreet: secondaryStreet, state: state, zipcode: zipcode, country: country, creatorID: creatorID, id: id, _type: _type, createdAt: createdAt, updatedAt: updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelObj.primaryStreet, forKey: .primaryStreet)
        try container.encodeIfPresent(self.modelObj.secondaryStreet, forKey: .secondaryStreet)
        try container.encode(self.modelObj.state, forKey: .state)
        try container.encode(self.modelObj.zipcode, forKey: .zipcode)
        try container.encode(self.modelObj.country, forKey: .country)
        try container.encode(self.modelObj.creatorID, forKey: .creatorID)
    }

}
