//
//  Dependent.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/8/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

struct Dependent: BackendPersistable, PersonClassifiable {
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String
    var dependencyID: Int

    init(firstname: String, lastname: String, dependencyID: Int) {
        self.firstname = firstname
        self.lastname = lastname
        self.dependencyID = dependencyID
    }
    
    init(with resource: DependentBackendResource) {
        let resourceObj = resource.modelObj
        self.init(firstname: resourceObj.firstname, lastname: resourceObj.lastname, dependencyID: resourceObj.dependencyID)
        self.id = resourceObj.id
        self.createdAt = resourceObj.createdAt
        self.updatedAt = resourceObj.updatedAt
    }
    
}
