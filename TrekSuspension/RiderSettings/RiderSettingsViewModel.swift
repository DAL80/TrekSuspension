//
//  RiderSettingsViewModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 7/27/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

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
}
