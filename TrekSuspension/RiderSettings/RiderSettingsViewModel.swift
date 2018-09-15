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
    // MARK: Public Methods
    func fetchAvailableModelYears(completion: @escaping ([Int]) -> Void) {
        let availableYears:[Int] = []
        
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
        var bikeModels:[BikeModel] = []
        
        BikeService().fetchModelsForYear(year) { response in
            switch response.result { 
            case let .success(value):
                let decoder = JSONDecoder()
                do {
                    bikeModels = try decoder.decode([BikeModel].self, from: value)
                    completion(bikeModels)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(bikeModels)
                }
                
            case let .failure(error):
                //TODO: Alert that bike models could not be fetched
                completion(bikeModels)
            }
        }
    }
    
    func saveRiderDefaults(year: Int, model: String, weight: Int, completion: @escaping (BikeConfigurationModel) -> Void) {
        // Set user defaults
        Defaults[.bikeModelYear] = year
        Defaults[.bikeModel] = model
        Defaults[.riderWeight] = weight
        Defaults[.hasSavedSettings] = true
        
        // Make request to get details for riders selected bike model
        var bikeConfiguration = BikeConfigurationModel()
        BikeService().fetchModelConfiguration(year: year, model: model, weightInLbs: weight) { response in
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
