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

struct Person: BackendResourceAssociated, PersonClassifiable {
    typealias AssociatedResource = PersonBackendResource
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var _backendResource: PersonBackendResource?

    init(firstname: String, lastname:String) {
        self.firstname = firstname
        self.lastname = lastname
    }
    
    init(with resource: PersonBackendResource) {
        self.init(firstname:  resource.firstname!, lastname: resource.lastname!)
        self.id = resource.id
        self.createdAt = resource.createdAt
        self.updatedAt = resource.updatedAt
        self._backendResource = resource
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
