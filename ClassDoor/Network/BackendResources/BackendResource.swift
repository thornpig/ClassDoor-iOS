//
//  BackendResource.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/9/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

protocol BackendPersistable {
    var id: Int? {get set}
    var createdAt: Date? {get set}
    var updatedAt: Date? {get set}
//    var backendResource: AssociatedResource {mutating get set}
//    init(with resource: AssociatedResource)
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

enum BackendResourceType: String {
    case User = "user"
    case Dependent = "dependent"
    case Class = "class"
    case ClassSession = "class_session"
    case Enrollment = "enrollment"
    case Organization = "organization"
    case Notification = "notification"
    case Address = "address"
    case TemplateLesson = "template_lesson"
    case Lesson = "lesson"
    case RepeatedLesson = "repeated_lesson"
    case Schedule = "schedule"
    case TimeSlot = "time_slot"
}

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

