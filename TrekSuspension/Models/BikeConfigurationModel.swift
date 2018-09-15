//
//  BikeSettingModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeSettingModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name = "modelName"
        case frontSuspension
        case rearSuspension
        case frontSettings
        case rearSettings
    }
    
    fileprivate var name: String = ""
    fileprivate var frontSuspension: String = ""
    fileprivate var rearSuspension: String = ""
    fileprivate var frontSettings:[SuspensionItemModel] =  [SuspensionItemModel]()
    fileprivate var rearSettings:[SuspensionItemModel] = [SuspensionItemModel]()
}

extension BikeSettingModel {
    func getModelName() -> String { return name }
    
    func getFrontSuspension() -> String { return frontSuspension }
    
    func getRearSuspension() -> String { return rearSuspension }
    
    func getFrontSettings() -> [SuspensionItemModel] { return frontSettings }
    
    func getRearSettings() -> [SuspensionItemModel] { return rearSettings }
}
