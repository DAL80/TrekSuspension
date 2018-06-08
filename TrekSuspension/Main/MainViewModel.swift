//
//  MainViewModel.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/7/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation


class MainViewModel {
    
    //MARK: Public Methods
    func fetchAvailableModelYears(completion: @escaping ([Int]) -> Void) {
        let availableYears:[Int] = []
        
        BikeService().fetchYears { response in
            switch response.result {
            case .success:
                print("success".localized())
            case .failure:
                print("warning_unable_to_fetch_years".localized())
            }
        }
    
        completion(availableYears)
    }
}
