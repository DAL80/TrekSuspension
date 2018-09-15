//
//  BikeConfigurationModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeConfigurationModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name = "modelName"
        case frontSuspension
        case rearSuspension
        case frontSettings
        case rearSettings
    }
    
    private var name: String = ""
    private var frontSuspension: String = ""
    private var rearSuspension: String = ""
    private var frontSettings:[SuspensionItemModel] =  [SuspensionItemModel]()
    private var rearSettings:[SuspensionItemModel] = [SuspensionItemModel]()
}

extension BikeConfigurationModel {
    func getModelName() -> String { return name }
    
    func getFrontSuspension() -> String { return frontSuspension }
    
    func getRearSuspension() -> String { return rearSuspension }
    
    func getFrontSettings() -> [SuspensionItemModel] { return frontSettings }
    
    func getRearSettings() -> [SuspensionItemModel] { return rearSettings }
}
