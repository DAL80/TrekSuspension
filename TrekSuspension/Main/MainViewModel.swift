//
//  MainViewModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/7/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class MainViewModel {
    
    func hasSavedRiderSettings() -> Bool {
        if Defaults[.hasSavedSettings] {
            return true
        }
        return false
    }
}
