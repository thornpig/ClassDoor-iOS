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
    typealias AssociatedResource = PersonBackendResource
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var firstname: String
    var lastname: String

    init(firstname: String, lastname:String) {
        self.firstname = firstname
        self.lastname = lastname
    }
    
}
