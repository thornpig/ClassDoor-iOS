//
//  BackendDataRequest.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/6/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation

enum BackendResourceType: String {
    case User
    case Uependent
    case Class
    case ClassSession
    case Enrollment
    case Notification
    case Address
    case TemplatedLesson
    case Lesson
}

protocol BackendPersistable: Codable {
    static var baseURLString: String {get}
    static func buildURLString(method: RequestMethod, id: Int?, queryString: String?, ownedBy: BackendPersistable?) -> String?
}

extension BackendPersistable where Self: BaseModel {
    static func buildURLString(method: RequestMethod, id: Int?, queryString: String? = nil, ownedBy: BackendPersistable? = nil) -> String? {
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

enum RequestConentType: String {
    case json = "application/json"
}

enum RequestMethod: String {
    case GET
    case PATCH
    case POST
    case DELETE
}

enum BackendDataRequest {
    case get(relURLString: String)
    case patch(relURLString: String, data: Data, contentType: RequestConentType)
    case post(relURLString: String, data: Data, contentType: RequestConentType)
    case delete(relURLString: String)
    
    
    var method: String {
        switch self {
        case .get(_):
            return RequestMethod.GET.rawValue
        case .patch(_, _, _):
            return RequestMethod.PATCH.rawValue
        case .post(_, _, _):
            return RequestMethod.POST.rawValue
        case .delete(_):
            return RequestMethod.DELETE.rawValue
        }
    }
    
    var urlRequest: URLRequest? {
        var url: URL?
        var requestData: Data?
        var requestContentType: RequestConentType?
        
        switch self {
        case .get(let relURLString):
            url = URL(string: BackendDataService.BASE_API_URL +  relURLString)
        case .patch(let  relURLString, let data, let contentType),
             .post(let  relURLString, let data, let contentType):
            url = URL(string: BackendDataService.BASE_API_URL +  relURLString)
            requestData = data
            requestContentType = contentType
        case .delete(let  relURLString):
            url = URL(string: BackendDataService.BASE_API_URL +  relURLString)
        }
        var request: URLRequest?
        if let url = url {
            request = URLRequest(url: url)
        }
        request?.httpMethod = self.method
        request?.httpBody = requestData
        request?.setValue(requestContentType?.rawValue, forHTTPHeaderField: "Content-Type")
        return request
    }
}

