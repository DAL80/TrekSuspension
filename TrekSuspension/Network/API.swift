//
//  API.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

public struct API {
    public static var config: HTTPConfig = SettingsHTTPConfig()
    
    public static func configure(_ request: inout URLRequest) {
        for (key, value) in API.config.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.timeoutInterval = API.config.requestTimeoutInterval
    }
}
