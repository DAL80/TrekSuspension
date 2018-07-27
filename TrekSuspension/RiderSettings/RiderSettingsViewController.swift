//
//  RiderSettingsViewController.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/7/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import UIKit

class RiderSettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var bikeModelYearPicker: UIPickerView!
    @IBOutlet weak var bikeModelPicker: UIPickerView!
    @IBOutlet weak var riderWeight: UITextField!
    @IBOutlet weak var saveAndCalcuate: UIButton!
    
    // MARK: Properties
    fileprivate let riderSettingsViewModel = RiderSettingsViewModel()
    fileprivate var availableYears: [Int] = []
    fileprivate var availableBikeModels: [BikeModel] = []
    
    // MARK: Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        fetchBikeModelYears()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    fileprivate func initialSetup() {
        bikeModelPicker.delegate = self
        bikeModelPicker.dataSource = self
        bikeModelYearPicker.delegate = self
        bikeModelYearPicker.dataSource = self
    }
    
    fileprivate func fetchBikeModelYears() {
        riderSettingsViewModel.fetchAvailableModelYears { [unowned self] result in
            self.availableYears = result
            self.bikeModelYearPicker.reloadAllComponents()
        }
    }
    
    fileprivate func fetchBikeModelsForSelectedYear(_ selectedYear: Int) {
        riderSettingsViewModel.fetchAvailableModelsForYear(selectedYear) { [unowned self] result in
            self.availableBikeModels = result
            self.bikeModelPicker.reloadAllComponents()
        }
    }
}

extension RiderSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return availableYears.count
        case 1:
            return availableBikeModels.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return String(availableYears[row])
        case 1:
            return String(availableBikeModels[row].getTitle())
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchBikeModelsForSelectedYear(availableYears[row])
    }
}
