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
    //MARK: - Public Methods
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
        
        // Make request to get details for riders selected bike model
        var bikeConfiguration: BikeConfigurationModel?
        BikeService().fetchModelConfiguration(year: year, model: model, weightInLbs: riderWeight) { response in
            switch response.result {
            case let .success(value):
                let decoder = JSONDecoder()
                do {
                    bikeConfiguration = try decoder.decode(BikeConfigurationModel.self, from: value)
                    completion(bikeConfiguration)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(bikeConfiguration)
                }
            case .failure:
                print("warning_unable_to_fetch_configuration".localized())
                completion(bikeConfiguration)
            }
        }
    }
}
