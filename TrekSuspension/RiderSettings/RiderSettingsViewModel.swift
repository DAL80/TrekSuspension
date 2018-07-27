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
        let bikeModels:[BikeModel] = []
        
        BikeService().fetchModelsForYear(year) { response in
            switch response.result {
            case let .success(value):
                guard let currentModels = value as? [BikeModel] else {
                    completion(bikeModels)
                    return
                }
                
                completion(currentModels)
            case .failure:
                completion(bikeModels)
            }
            
        }
    }
}
