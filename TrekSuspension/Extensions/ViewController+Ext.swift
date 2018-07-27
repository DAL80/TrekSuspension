//
//  ViewController+Ext.swift
//  TrekSuspension
//
//  Created by Darren Larson on 7/27/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIViewController {
    
    public func makeToast(_ alertMsg: String, position: ToastDisplay = .default, attachToModal: Bool = false) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if !attachToModal {
            window.rootViewController?.view.makeToastMsg(alertMsg, position:position)
        } else {
            window.rootViewController?.presentedViewController?.view.makeToastMsg(alertMsg,position:position)
        }
    }
    
}
