//
//  BackendDataService.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/6/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation


struct BackendDataService {
    static let BASE_API_URL = "http://192.168.1.104:5000/api/v1"
    private init() {
    }
    static var shared = BackendDataService()
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    mutating func send(request: BackendDataRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let urlRequest  = request.urlRequest {
            let dataTask = self.session.dataTask(with: urlRequest, completionHandler: completionHandler)
            dataTask.resume()
        }
    }
    
    func save<T: BackendPersistable>(_ obj: T?, completionHandler: @escaping (T?) -> ())  {
        if obj == nil {
            return
        }
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .customISO8601
        let encodedObj = try! encoder.encode(obj)
        print(String(data: encodedObj, encoding: .utf8)!)
        let relURLString = type(of: obj!).buildURLString(method: .POST, id: nil, queryString: nil, ownedBy: nil)
        let request = BackendDataRequest.post(relURLString: relURLString!, data: encodedObj, contentType: RequestConentType.json)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            print(String(data: data!, encoding: .utf8))
            let returnedData = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String,  Any>
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            if let wrappedData = returnedData["data"] as? Dictionary<String, Any> {
                let decodedObj = try? decoder.decode(T.self, from: try! JSONSerialization.data(withJSONObject: wrappedData))
                completionHandler(decodedObj)
            }
        }
    }
    
    func getWithID<T: BackendPersistable>(_ id: Int, type: T.Type, completionHandler: @escaping (T?) -> ())  {
        let relURLString = type.buildURLString(method: .GET, id: id, queryString: nil, ownedBy: nil)
        let request = BackendDataRequest.get(relURLString: relURLString!)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            print(String(data: data!, encoding: .utf8))
            let returnedData = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String,  Any>
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            if let wrappedData = returnedData["data"] as? Dictionary<String, Any> {
                let decodedObj = try? decoder.decode(T.self, from: try! JSONSerialization.data(withJSONObject: wrappedData))
                completionHandler(decodedObj)
            }
        }
    }
    
    func patchWithID<T: BackendPersistable>(_ id: Int, type: T.Type, data:  [String: Any], completionHandler: @escaping (T?) -> ())  {
        let relURLString = type.buildURLString(method: .PATCH, id: id, queryString: nil, ownedBy: nil)
        let encodedData = try! JSONSerialization.data(withJSONObject: data)
        let request = BackendDataRequest.patch(relURLString: relURLString!, data:encodedData , contentType: .json)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            let returnedData = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String,  Any>
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            if let wrappedData = returnedData["data"] as? Dictionary<String, Any> {
                let decodedObj = try? decoder.decode(T.self, from: try! JSONSerialization.data(withJSONObject: wrappedData))
                completionHandler(decodedObj)
            }
        }
    }
}
