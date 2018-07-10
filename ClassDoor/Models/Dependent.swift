//
//  Dependent.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Dependent: BackendResourceAssociated, PersonClassifiable {
    typealias AssociatedResource = DependentBackendResource
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var dependencyID: Int
    var _backendResource: DependentBackendResource?

    init(firstname: String, lastname: String, dependencyID: Int) {
        self.firstname = firstname
        self.lastname = lastname
        self.dependencyID = dependencyID
    }
    
    init(with resource: DependentBackendResource) {
        self.init(firstname: resource.firstname!, lastname: resource.lastname!, dependencyID: resource.dependencyID!)
        self._backendResource = resource
    }
    
}
