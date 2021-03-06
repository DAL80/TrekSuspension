//
//  Constants.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

struct Services {
    static let baseURL = "http://ws.trekbikes.com/"
    static let assetURL = "http://suspension.trekbikes.com/"
    static let requestTimeoutInterval = 30.0
}

extension DefaultsKeys {
    static let bikeModelYear = DefaultsKey<Int?>("bikeModelYear")
    static let bikeModel = DefaultsKey<String?>("bikeModel")
    static let riderWeight = DefaultsKey<Int?>("riderWeight")
    static let hasSavedSettings = DefaultsKey<Bool>("hasSavedSettings")
}
