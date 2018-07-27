//
//  BikeService.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Alamofire

class BikeService {
    
    func fetchYears(completion: @escaping ((DataResponse<Any>) -> Void)) {
        API.BikeServiceData.fetchYears.perform { response in
            completion(response)
        }
    }
    
    func fetchModelsForYear(_ year: Int, completion: @escaping ((DataResponse<Any>)) -> Void) {
        API.BikeServiceData.fetchModelsForYear(year: year).perform { response in
            completion(response)
        }
    }

}
