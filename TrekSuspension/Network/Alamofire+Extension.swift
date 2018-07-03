//
//  Alamofire+Extension.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Alamofire

extension URLRequestConvertible {
    
    //TODO: Need to update to let URL string be set if it doesn't match the default.
    func makeRequest(path: String, httpMethod: HTTPMethod, parameters: [String: Any]? = nil) throws -> URLRequest {
        
        var request = URLRequest(url: API.config.baseURL.appendingPathComponent(path))
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        if httpMethod == .get {
            return try URLEncoding.default.encode(request, with: parameters)
        }

        return try JSONEncoding.default.encode(request, with: parameters)
    }
    
    func perform(completion: @escaping ((DataResponse<Any>) -> Void)) {
        Alamofire.request(self).validate().responseJSON { response in
            completion(response)
        }
    }
}
