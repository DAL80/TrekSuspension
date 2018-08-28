//
//  Alamofire+Extension.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Alamofire

extension URLRequestConvertible {

    //Sets up and returns URL Request
    func makeRequest(baseUrl:URL = API.config.baseURL, path: String, httpMethod: HTTPMethod, parameters: [String: Any]? = nil) throws -> URLRequest {
        
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        if httpMethod == .get {
            return try URLEncoding.default.encode(request, with: parameters)
        }

        return try JSONEncoding.default.encode(request, with: parameters)
    }
    
    //Runs the request and returns the results
    func perform(completion: @escaping ((DataResponse<Any>) -> Void)) {
        Alamofire.request(self).validate().responseJSON { response in
            completion(response)
        }
    }
    
    func perform(completion: @escaping ((DataResponse<Data>) -> Void)) {
        Alamofire.request(self).validate().responseData(completionHandler: { response in
            completion(response)
        })
    }
}
