//
//  MainViewController.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/6/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
    
    // MARK: Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if mainViewModel.hasSavedRiderSettings() {
            fetchSavedSettings()
            return
        }
        
        //no user settings detected
        showRiderSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Settings Methods
    fileprivate func showRiderSettings() {
        //TODO: This will open rider settings screen to enter data
        
    }
    
    fileprivate func fetchSavedSettings() {
        //TODO: This will fetch bike model details based on rider settings
        
    }
}
