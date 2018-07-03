//
//  BikeSettingModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeSettingModel {
    
    private enum CodingKeys: String, CodingKey {
        case name = "modelName"
        case frontSuspension
        case rearSuspension
        case frontSettings
        case rearSettings
    }
    
    public var modelName: String = ""
    public var frontSuspension: String = ""
    public var rearSuspension: String = ""
//    public var frontSettings:[SuspensionItemModel] = SuspensionItemModel()
//    public var rearSettings:[SuspensionItemModel] = SuspensionItemModel()
}
