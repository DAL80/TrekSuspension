//
//  API+BikeServiceData.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Alamofire

extension API {
    enum BikeServiceData {
        case fetchYears
        case fetchModelsForYear(year: Int)
        case fetchModelConfiguration(year: Int, model: String, weightInLbs: Int)
        case fetchModelImage(model: String)
        case fetchImage(url: String)
    }
}

extension API.BikeServiceData: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .fetchYears:
            return try makeRequest(path: "suspension/years/", httpMethod: .get)
        case let .fetchModelsForYear(year):
            return try makeRequest(path: "suspension/models/\(year)", httpMethod: .get)
        case let .fetchModelConfiguration(year, model, weightInLbs):
            return try makeRequest(path: "suspension/settings/\(model)/\(weightInLbs)/\(year)", httpMethod: .get)
        case let .fetchModelImage(model):
            return try makeRequest(baseUrl: URL(string: Services.assetURL)!, path: "image/\(model)", httpMethod: .get)
        case let .fetchImage(url):
            return try makeRequest(baseUrl: URL(string: url)!, path: "", httpMethod: .get)
        }
    }
}
