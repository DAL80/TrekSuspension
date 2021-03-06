//
//  RiderSettingsViewModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 7/27/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class RiderSettingsViewModel {
    // MARK: - Public Methods
    func fetchAvailableModelYears(completion: @escaping ([Int]) -> Void) {
        let availableYears: [Int] = []

        BikeService().fetchYears { response in
            switch response.result {
            case let .success(value):
                guard let currentYears = value as? [Int] else {
                    completion(availableYears)
                    return
                }

                completion(currentYears)
            case .failure:
                print("warning_unable_to_fetch_years".localized())
                completion(availableYears)
            }
        }
    }

    func fetchAvailableModelsForYear(_ year: Int, completion: @escaping ([BikeModel]) -> Void) {
        BikeService().fetchModelsForYear(year) { response in
            switch response.result {
            case let .success(value):
                API.parseResponse(type: [BikeModel].self, responseValue: value, completion: { item in
                    completion(item ?? [])
                })
            case .failure:
                print("warning_unable_to_fetch_years".localized())
                completion([BikeModel]())
            }
        }
    }

    func saveRiderDefaults(year: Int, model: String, weight: Int) {
        Defaults[.bikeModelYear] = year
        Defaults[.bikeModel] = model
        Defaults[.riderWeight] = weight
        Defaults[.hasSavedSettings] = true
    }
}
