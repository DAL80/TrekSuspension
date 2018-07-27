//
//  BikeModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "bikeModelId"
        case suspensionId
        case statusId
        case year
        case identifier
        case title
        case frontSuspension
        case rearSuspension
    }
    
    fileprivate var id: Int = 0
    fileprivate var suspensionId: Int = 0
    fileprivate var statusId: Int = 0
    fileprivate var year: Int = 0
    fileprivate var identifier: String = ""
    fileprivate var title: String = ""
    fileprivate var frontSuspension: String = ""
    fileprivate var rearSuspension: String = ""
    fileprivate var url: String? = ""
    
}


extension BikeModel {
    func getId() -> Int { return id }
    
    func getSuspensionId() -> Int { return suspensionId }
    
    func getStatusId() -> Int { return statusId }
    
    func getYear() -> Int { return year }
    
    func getIdentifier() -> String { return identifier }
    
    func getTitle() -> String { return title }
    
    func getFrontSuspension() -> String { return frontSuspension }
    
    func getRearSuspension() -> String { return rearSuspension }
    
    func getUrl() -> String? { return url }
}
