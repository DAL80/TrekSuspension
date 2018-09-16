//
//  BikeService.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/5/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Alamofire
import AlamofireImage

class BikeService {
    
    func fetchYears(completion: @escaping ((DataResponse<Any>) -> Void)) {
        API.BikeServiceData.fetchYears.perform { response in
            completion(response)
        }
    }
    
    func fetchModelsForYear(_ year: Int, completion: @escaping ((DataResponse<Data>)) -> Void) {
        API.BikeServiceData.fetchModelsForYear(year: year).perform { response in
            completion(response)
        }
    }

    func fetchModelConfiguration(year: Int, model:String, weightInLbs: Int, completion: @escaping ((DataResponse<Data>)) -> Void) {
        API.BikeServiceData.fetchModelConfiguration(year: year, model: model, weightInLbs: weightInLbs).perform { response in
            completion(response)
        }
    }
    
    func fetchModelImage(model: String, completion: @escaping ((DataResponse<Data>)) -> Void) {
        API.BikeServiceData.fetchModelImage(model: model).perform { response in
            completion(response)
        }
    }
    
    func fetchImage(_ url: String, completion: @escaping ((DataResponse<Image>)) -> Void) {
        var tmpUrl = url
        if url.prefix(4).lowercased() != "http:" {
            tmpUrl = "http:\(url)"
        }

        Alamofire.request(tmpUrl).responseImage { response in
            completion(response)
        }
    }
}
