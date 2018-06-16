//
//  BikeModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct Model {
    
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
    
    public var id: Int = 0
    public var suspensionId: Int = 0
    public var statusId: Int = 0
    public var year: Int = 0
    fileprivate var identifier: String = ""
    public var title: String = ""
    public var frontSuspension: String = ""
    public var rearSuspension: String = ""
    public var url: String? = ""
}
