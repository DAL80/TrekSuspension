//
//  BikeYearModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/8/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeYearModel: Codable {
    fileprivate var years: [Int] = []
    
    init(_ currentYears:[Int]) {
        years = currentYears
    }
}

extension BikeYearModel {
    func getYears() -> [Int] { return years }
}
