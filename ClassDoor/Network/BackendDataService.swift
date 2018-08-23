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
    
    func save<T: BackendResource>(_ obj: T, completionHandler: @escaping (T?) -> ())  {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .customISO8601
        guard let encodedObj = try? encoder.encode(obj) else {
            return
        }
        //print(String(data: encodedObj, encoding: .utf8)!)
        guard let relURLString = type(of: obj).buildURLString(method: .POST, identifier: nil, queryString: nil, ownedBy: nil) else {
            print("failed to build request url string!")
            return
        }
        let request = BackendDataRequest.post(relURLString: relURLString, data: encodedObj, contentType: RequestConentType.json)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            guard let data = data else {
                print("response data is nil!")
                return
            }
            //print(String(data: data, encoding: .utf8))
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("http response failed!")
                    return
            }
            guard let returnedDataDict = try? JSONSerialization.jsonObject(with: data) as! Dictionary<String,  Any>,
                let wrappedDataDict = returnedDataDict["data"] as? Dictionary<String, Any>,
                let wrappedJson = try? JSONSerialization.data(withJSONObject: wrappedDataDict) else {
                print("failed to unwrap response data!")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            guard let decodedObj = try? decoder.decode(T.self, from: wrappedJson) else {
                print("failed to decode json data retrieved from response for \(T.self)!")
                return
            }
            completionHandler(decodedObj)
        }
    }
    
    func getWithIdentifier<T: BackendResource>(_ identifier: LosslessStringConvertible, type: T.Type, completionHandler: @escaping (T?) -> ())  {
        guard let relURLString = type.buildURLString(method: .GET, identifier: identifier, queryString: nil, ownedBy: nil) else {
            print("failed to build request url string!")
            return
        }
        let request = BackendDataRequest.get(relURLString: relURLString)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            guard let data = data else {
                print("response data is nil!")
                return
            }
            //print(String(data: data, encoding: .utf8))
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("http response failed!")
                    return
            }
            guard let returnedDataDict = try? JSONSerialization.jsonObject(with: data) as! Dictionary<String,  Any>,
                let wrappedDataDict = returnedDataDict["data"] as? Dictionary<String, Any>,
                let wrappedJson = try? JSONSerialization.data(withJSONObject: wrappedDataDict) else {
                    print("failed to unwrap response data!")
                    return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            guard let decodedObj = try? decoder.decode(T.self, from: wrappedJson) else {
                print("failed to decode json data retrieved from response for \(T.self)!")
                return
            }
            completionHandler(decodedObj)
        }
    }
    
    func getWithIdentifiers<T: BackendResource>(_ identifiers: [LosslessStringConvertible], type: T.Type, completionHandler: @escaping ([T.ModelType]) -> ())  {
        let dpGroup = DispatchGroup()
        var items = [T.ModelType]()
        for id in identifiers {
            dpGroup.enter()
            BackendDataService.shared.getWithIdentifier(id, type: type) {
                defer {
                    dpGroup.leave()
                }
                guard let item = $0?.modelObj else {
                    print("could not find item \(id)")
                    return
                }
                items.append(item)
            }
        }
        dpGroup.notify(queue: DispatchQueue.main) {
            completionHandler(items)
        }
    }
    
    func patchWithID<T: BackendResource>(_ id: Int, type: T.Type, data:  [String: Any], completionHandler: @escaping (T?) -> ())  {
        guard let encodedData = try? JSONSerialization.data(withJSONObject: data) else {
            print("failed to encode patch data!")
            return
        }
        guard let relURLString = type.buildURLString(method: .PATCH, identifier: id, queryString: nil, ownedBy: nil) else {
            print("failed to build request url string!")
            return
        }
        let request = BackendDataRequest.patch(relURLString: relURLString, data:encodedData , contentType: .json)
        BackendDataService.shared.send(request: request) {
            data, response, error in
            guard let data = data else {
                print("response data is nil!")
                return
            }
            //print(String(data: data, encoding: .utf8))
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("http response failed!")
                    return
            }
            guard let returnedDataDict = try? JSONSerialization.jsonObject(with: data) as! Dictionary<String,  Any>,
                let wrappedDataDict = returnedDataDict["data"] as? Dictionary<String, Any>,
                let wrappedJson = try? JSONSerialization.data(withJSONObject: wrappedDataDict) else {
                    print("failed to unwrap response data!")
                    return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            guard let decodedObj = try? decoder.decode(T.self, from: wrappedJson) else {
                print("failed to decode json data retrieved from response for \(T.self)!")
                return
            }
            completionHandler(decodedObj)
        }
    }
}
