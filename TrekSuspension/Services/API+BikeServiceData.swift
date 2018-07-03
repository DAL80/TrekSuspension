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
        case fetchModelDetails(model: String)
        case fetchModelSettings (model:String, weightInLbs: Int, year: Int)
    }
}

extension API.BikeServiceData: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .fetchYears:
            return try makeRequest(path: "suspension/years/", httpMethod: .get)
        case let .fetchModelsForYear (year):
            return try makeRequest(path: "/suspension/models/\(year)", httpMethod: .get)
        case let .fetchModelDetails (model):
            return try makeRequest(path: "image/\(model)", httpMethod: .get)
        case let .fetchModelSettings(model, weightInLbs, year):
            return try makeRequest(path: "suspension/settings/\(model)/\(weightInLbs)/\(year)", httpMethod: .get)
        }
    }
}
