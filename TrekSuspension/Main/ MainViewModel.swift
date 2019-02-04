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
    // MARK: - Public Methods
    func hasSavedRiderSettings() -> Bool {
        return Defaults[.hasSavedSettings]
    }

    func fetchRidersBikeConfiguration(completion: @escaping (BikeConfigurationModel?) -> Void) {
        guard
            let year = Defaults[.bikeModelYear],
            let model = Defaults[.bikeModel],
            let riderWeight = Defaults[.riderWeight] else {
                print("missing_rider_defaults".localized())
                return
        }

        BikeService().fetchModelConfiguration(year: year, model: model, weightInLbs: riderWeight) { response in
            switch response.result {
            case let .success(value):
                API.parseResponse(type: BikeConfigurationModel.self, responseValue: value, completion: { item in
                    completion(item)
                })
            case .failure:
                print("warning_unable_to_fetch_configuration".localized())
                completion(nil)
            }
        }
    }

    func fetchBikeModelImage(_ model: String, completion: @escaping (BikeModelImage?) -> Void) {
        BikeService().fetchModelImage(model: model) { response in
            switch response.result {
            case let .success(value):
                API.parseResponse(type: BikeModelImage.self, responseValue: value, completion: { item in
                    completion(item)
                })
            case .failure:
                print("warning_unable_to_fetch_model_image".localized())
                completion(nil)
            }
        }
    }

    func fetchImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        BikeService().fetchImage(url) { response in
            switch response.result {
            case let .success(value):
                completion(value)
            case .failure:
                print("warning_unable_to_fetch_image".localized())
                completion(nil)
            }
        }
    }
}
