//
//  SuspensionItemModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct SuspensionItemModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case relationTypeId
        case title = "settingTypeTitle"
        case units
        case value
    }
    
    private var relationTypeId: Int = 0
    private var title: String = ""
    private var units: String = ""
    private var value: String = ""
}

extension SuspensionItemModel {
    func getTitle() -> String { return title }
    func getUnits() -> String { return units }
    func getValue() -> String { return value }
}
