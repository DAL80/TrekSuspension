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
    // MARK: - IBOutlets
    @IBOutlet weak var bikeModelName: UILabel!
    @IBOutlet weak var bikeImage: UIImageView!
    @IBOutlet weak var suspensionType: UISegmentedControl!
    @IBOutlet weak var suspensionTitle: UILabel!
    @IBOutlet weak var spring: UILabel!
    @IBOutlet weak var rebound: UILabel!
    @IBOutlet weak var shockStroke: UILabel!
    @IBOutlet weak var forkShockLabel: UILabel!
    @IBOutlet weak var shockSag: UILabel!

    // MARK: - Properties
    private let mainViewModel = MainViewModel()
    private var riderBikeConfig: BikeConfigurationModel?

    // MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        suspensionType.addTarget(self, action: #selector(suspensionChanged), for: .valueChanged)

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
}

extension MainViewController {
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
        var suspensionName = ""
        var suspensionSettings = [SuspensionItemModel]()
        switch suspensionType.selectedSegmentIndex {
        case 0:
            suspensionName = currentBikeConfig.getFrontSuspension()
            suspensionSettings = currentBikeConfig.getFrontSettings()
        case 1:
            suspensionName = currentBikeConfig.getRearSuspension()
            suspensionSettings = currentBikeConfig.getRearSettings()
        default:
            return
        }

        suspensionTitle.text = suspensionName
        for item in suspensionSettings {
            let tmpItemValue = "\(item.getValue()) \(item.getUnits())"

            switch item.getTitle().lowercased() {
            case "spring":
                spring.text = tmpItemValue
            case "rebound":
                rebound.text = tmpItemValue
            case "fork sag":
                forkShockLabel.text = "Fork Sag"
                shockSag.text = tmpItemValue
            case "shock sag":
                forkShockLabel.text = "Shock Sag"
                shockSag.text = tmpItemValue
            case "shock stroke":
                shockStroke.text = tmpItemValue
            default:
                return
            }
        }
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

    private func fetchImage(_ url: String) {
        mainViewModel.fetchImage(url) { [weak self] result in
            guard
                let `self` = self else { return }

            self.bikeImage.image = result
        }
    }

    @objc private func suspensionChanged() {
        clearSuspensionValues()
        updateDataDisplayed()
    }

    private func clearSuspensionValues() {
        suspensionTitle.text = "not_available".localized()
        spring.text = "not_available".localized()
        rebound.text = "not_available".localized()
        shockSag.text = "not_available".localized()
        shockStroke.text = "not_available".localized()
    }
}
