//
//  SuspensionItemModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct SuspensionItemModel {
    
    private enum CodingKeys: String, CodingKey {
        case relationTypeId
        case title = "settingTypeTitle"
        case units
        case value
    }
    
    public var relationTypeId: Int = 0
    public var title: String = ""
    public var units: String = ""
    public var value: String = ""
}
