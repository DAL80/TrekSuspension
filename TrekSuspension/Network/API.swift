//
//  API.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import Alamofire

public struct API {
    // MARK: - Properties
    public static var config: HTTPConfig = SettingsHTTPConfig()

    // MARK: - Public Methods
    public static func configure(_ request: inout URLRequest) {
        for (key, value) in API.config.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        request.timeoutInterval = API.config.requestTimeoutInterval
    }

    public static func parseResponse<T: Decodable>(type: T.Type,
                                                   responseValue: Data,
                                                   decoder: JSONDecoder = JSONDecoder(),
                                                   completion: @escaping (T?) -> Void) {

        var itempParseItem: T?
        do {
            itempParseItem = try decoder.decode(type, from: responseValue)
            completion(itempParseItem)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(itempParseItem)
        }
    }
}
