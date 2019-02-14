//
//  RiderSettingsViewController.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/7/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class RiderSettingsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var bikeModelYear: UITextField!
    @IBOutlet private var bikeModel: UITextField!
    @IBOutlet private var riderWeight: UITextField!
    @IBOutlet private var saveAndCalcuate: UIButton!

    // MARK: - Properties
    private var bikeModelYearPicker = UIPickerView.init()
    private var bikeModelPicker = UIPickerView.init()
    private let riderSettingsViewModel = RiderSettingsViewModel()
    private var availableYears: [Int] = []
    private var availableBikeModels: [BikeModel] = []
    private var isProcessing = false

    lazy private var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }()

    // MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        fetchBikeModelYears()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func initialSetup() {
        bikeModelPicker.delegate = self
        bikeModelPicker.dataSource = self
        bikeModelPicker.tag = 1

        bikeModelYearPicker.delegate = self
        bikeModelYearPicker.dataSource = self
        bikeModelYearPicker.tag = 0

        bikeModelYear.inputView = bikeModelYearPicker
        bikeModelYear.inputAccessoryView = toolbar

        bikeModel.inputView = bikeModelPicker
        bikeModel.inputAccessoryView = toolbar

        if let savedWeight = Defaults[.riderWeight] {
            riderWeight.text = "\(savedWeight)"
        }
    }
}

// MARK: - Data Methods
extension RiderSettingsViewController {
    private func fetchBikeModelYears() {
        riderSettingsViewModel.fetchAvailableModelYears { [weak self] result in
            guard let `self` = self else { return }

            self.availableYears = result
            self.bikeModelYearPicker.reloadAllComponents()
            self.selectDefaultBikeYear()
        }
    }

    private func fetchBikeModelsForSelectedYear(_ selectedYear: Int) {
        riderSettingsViewModel.fetchAvailableModelsForYear(selectedYear) { [weak self] result in
            guard let `self` = self else { return }

            self.availableBikeModels = result
            self.bikeModelPicker.reloadAllComponents()
            self.selectDefaultBikeModel()
        }
    }
}

// MARK: - IBAction Methods
extension RiderSettingsViewController {
    @IBAction func saveClicked(_ sender: Any) {
        saveRiderSettings()
    }
}

// MARK: - Private Methods
extension RiderSettingsViewController {
    private func updateBikeModelYear(_ year: String) {
        bikeModelYear.text = year
    }

    private func updateBikeModel(_ model: String) {
        bikeModel.text = model
    }

    @objc private func doneClick() {
        bikeModelYear.resignFirstResponder()
        bikeModel.resignFirstResponder()
    }
}

// MARK: - Actions Methods
extension RiderSettingsViewController {
    private func selectDefaultBikeYear() {
        var rowToSelect = 0
        var bikeYear = availableYears.first

        if let savedYear = Defaults[.bikeModelYear] {
            bikeYear = savedYear
            rowToSelect = availableYears.index(of: savedYear) ?? 0
        }

        if let displayBikeYearText = bikeYear {
            updateBikeModelYear(String(displayBikeYearText))
        }

        self.bikeModelYearPicker.selectRow(rowToSelect, inComponent: 0, animated: false)
        self.pickerView(self.bikeModelYearPicker, didSelectRow: rowToSelect, inComponent: 0)

    }

    private func selectDefaultBikeModel() {
        var rowToSelect = 0
        if let savedModel = Defaults[.bikeModel] {
            _ = availableBikeModels.enumerated().compactMap { index, bike in
                if bike.getIdentifier().lowercased() == savedModel.lowercased() {
                    rowToSelect = index
                    updateBikeModel(bike.getTitle())
                }
            }
        }

        self.bikeModelPicker.selectRow(rowToSelect, inComponent: 0, animated: false)
        self.pickerView(self.bikeModelPicker, didSelectRow: rowToSelect, inComponent: 0)
    }

    private func saveRiderSettings() {
        if isProcessing { return }
        guard let riderWeight = riderWeight.text, !riderWeight.isEmpty, let weight = Int(riderWeight), weight > 0 else {
            makeToast("valid_rider_weight_required".localized())
            return
        }

        isProcessing = true

        let selectedBikeYear = self.availableYears[bikeModelYearPicker.selectedRow(inComponent: 0)]
        let selectedBikeModel = self.availableBikeModels[bikeModelPicker.selectedRow(inComponent: 0)].getIdentifier()

        riderSettingsViewModel.saveRiderDefaults(year: selectedBikeYear, model: selectedBikeModel, weight: weight)
        isProcessing = false
        closeRiderSettings()
    }

    private func closeRiderSettings() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - PickerView Delegate Methods
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
        switch pickerView.tag {
        case 0:
            fetchBikeModelsForSelectedYear(availableYears[row])
            updateBikeModelYear(String(availableYears[row]))
        case 1:
            updateBikeModel(String(availableBikeModels[row].getTitle()))
        default:
            return
        }
    }
}
