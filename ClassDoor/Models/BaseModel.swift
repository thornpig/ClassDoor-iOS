//
//  BaseModel.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol BaseModel {
    var id: Int? {get set}
    var createdAt: Date? {get set}
    var updatedAt: Date? {get set}
}
