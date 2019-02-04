//
//  HTTPConfig.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

public protocol HTTPConfig {
    var baseURL: URL! { get }
}

public extension HTTPConfig {
    public var requestTimeoutInterval: TimeInterval {
        return Services.requestTimeoutInterval
    }

    public var headers: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"

        return headers
    }
}

public struct SettingsHTTPConfig: HTTPConfig {
    public private(set) var baseURL: URL!
    public init() {
        self.baseURL = URL(string: Services.baseURL)
    }
}
