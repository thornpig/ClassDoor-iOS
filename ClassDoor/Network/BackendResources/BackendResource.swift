//
//  BackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

enum BackendResourceType: String {
    case User
    case Dependent
    case Class
    case ClassSession
    case Enrollment
    case Organization
    case Notification
    case Address
    case TemplateLesson
    case Lesson
    case RepeatedLesson
    case Schedule
    case TimeSlot
}

protocol BackendPersistable {
    associatedtype AssociatedResource: BackendResource
    var id: Int? {get set}
    var createdAt: Date? {get set}
    var updatedAt: Date? {get set}
    func buildBackendResource() -> AssociatedResource
//    var backendResource: AssociatedResource {mutating get set}
//    init(with resource: AssociatedResource)
}

extension BackendPersistable where AssociatedResource.ModelType == Self {
    func buildBackendResource() -> AssociatedResource {
        return AssociatedResource(of: self)
    }
}
//extension BackendResourceAssociated where AssociatedResource.ModelType == Self {
//
//    var backendResource: AssociatedResource {
//        mutating get {
//            if self._backendResource == nil {
//                self._backendResource = AssociatedResource.buildResource(with: self)
//            }
//            return self._backendResource!
//        }
//        set {
//            self._backendResource = newValue
//        }
//    }
//}



protocol BackendResource: Codable {
    associatedtype ModelType: BackendPersistable
    var modelObj: ModelType {get set}
    static var baseURLString: String {get}
    static func buildURLString(method: RequestMethod, id: Int?, queryString: String?, ownedBy: ModelType?) -> String?
    init(of obj: ModelType)
    //    static func buildResource(with obj: ModelType) -> Self
}

extension BackendResource {
    static func buildURLString(method: RequestMethod, id: Int?, queryString: String? = nil, ownedBy: ModelType? = nil) -> String? {
        switch method {
        case .GET,
             .PATCH,
             .DELETE:
            return "\(Self.baseURLString)/\(id!)"
        case .POST:
            return Self.baseURLString
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

