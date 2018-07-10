//
//  BackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol BackendResourceAssociated {
    associatedtype AssociatedResource: BackendPersistable
    var id: Int? {get set}
    var createdAt: Date? {get set}
    var updatedAt: Date? {get set}
    var _backendResource: AssociatedResource? {get set}
}

extension BackendResourceAssociated where AssociatedResource.ModelType == Self {

    var backendResource: AssociatedResource? {
            mutating get {
                if self._backendResource == nil {
                    self._backendResource = AssociatedResource.buildResource(with: self)
                }
                return self._backendResource
            }
            set {
                self._backendResource = newValue
            }
        }
}

struct BaseBackendResource: Codable {
    var id: Int?
    var type: String?
    
    enum codingKeys: String, CodingKey {
        case id
        case type = "_type"
    }
}

