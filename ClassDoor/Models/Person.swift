//
//  Person.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol PersonClassifiable {
    var firstname: String {get set}
    var lastname: String {get set}
}

struct Person: BackendPersistable, PersonClassifiable {
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String

    init(firstname: String, lastname:String) {
        self.firstname = firstname
        self.lastname = lastname
    }
    
    init(with resource: PersonBackendResource) {
        let resourceObj = resource.modelObj
        self.init(firstname:  resourceObj.firstname, lastname: resourceObj.lastname)
        self.id = resourceObj.id
        self.createdAt = resourceObj.createdAt
        self.updatedAt = resourceObj.updatedAt
    }

//    var backendResource: PersonBackendResource? {
//        get {
//            if self._backendResource == nil {
//                self._backendResource = PersonBackendResource(of: self)
//            }
//            return self._backendResource
//        }
//        set {
//            self._backendResource = newValue
//        }
//    }
    
}
