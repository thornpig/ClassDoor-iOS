//
//  BackendDataRequest.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/6/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation



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


