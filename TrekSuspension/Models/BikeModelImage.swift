//
//  BikeModelImage.swift
//  TrekSuspension
//
//  Created by Darren Larson on 9/16/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

struct BikeModelImage: Codable {
    private var status: String
    private var url: String
}

extension BikeModelImage {
    func getStatus() -> String { return status }
    func getUrl() -> String { return url }
}
