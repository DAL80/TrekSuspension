//
//  MainViewController.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/6/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MainViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var bikeModelName: UILabel!
    @IBOutlet weak var bikeImage: UIImageView!
    
    // MARK: - Properties
    private let mainViewModel = MainViewModel()
    private var riderBikeConfig: BikeConfigurationModel?
    
    // MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !mainViewModel.hasSavedRiderSettings() {
            //no user settings detected
            showRiderSettings()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mainViewModel.hasSavedRiderSettings() {
            fetchSavedSettings()
            fetchBikeImage()
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Settings Methods
    private func showRiderSettings() {
        makeToast("enter_rider_settings".localized())
        performSegue(withIdentifier: "RiderSettingsSegue", sender: nil)
    }

    // MARK: - Data Methods
    private func fetchSavedSettings() {
        mainViewModel.fetchRidersBikeConfiguration { [weak self] result in
            guard let `self` = self else { return }
        
            self.riderBikeConfig = result
            self.updateDataDisplayed()
        }
    }
    
    private func updateDataDisplayed() {
        guard let currentBikeConfig = riderBikeConfig else {
            makeToast("no_configuration_data".localized())
            return
        }
        
        bikeModelName.text = currentBikeConfig.getModelName()
    }
    
    private func fetchBikeImage() {
        guard
            let modelName = Defaults[.bikeModel] else { return }
        
        mainViewModel.fetchBikeModelImage(modelName) { [weak self] result in
            guard
                let `self` = self else { return }
            guard
                let bikeModelImage = result else { return }
            
            self.fetchImage(bikeModelImage.getUrl())
        }
    }
    
    private func fetchImage(_ url:String) {
        mainViewModel.fetchImage(url) { [weak self] result in
            guard
                let `self` = self else { return }
            
            self.bikeImage.image = result
        }
    }
}
