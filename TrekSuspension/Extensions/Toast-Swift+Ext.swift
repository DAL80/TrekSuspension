//
//  Toast-Swift+Ext.swift
//  TrekSuspension
//
//  Created by Darren Larson on 7/27/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation
import Toast_Swift

public enum ToastDisplay: CGFloat {
    case top
    case center
    case `default` = 60.0
    case aboveToolbar = 100.0

    func centerPoint(forToast toast: UIView, inSuperview superview: UIView) -> CGPoint {
        let topPadding: CGFloat = ToastManager.shared.style.verticalPadding + superview.csSafeAreaInsets.top
        let bottomPadding: CGFloat = ToastManager.shared.style.verticalPadding + superview.csSafeAreaInsets.bottom

        switch self {
        case .top:
            return CGPoint(x: superview.bounds.size.width / 2.0, y: (toast.frame.size.height / 2.0) + topPadding)
        case .center:
            return CGPoint(x: superview.bounds.size.width / 2.0, y: superview.bounds.size.height / 2.0)
        case .default:
            return CGPoint(x: superview.bounds.size.width / 2.0,
                           y: (superview.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding - self.rawValue)
        case .aboveToolbar:
            return CGPoint(x: superview.bounds.size.width / 2.0,
                           y: (superview.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding - self.rawValue)
        }
    }
}

public extension UIView {
    public func makeToastMsg(_ message: String?, duration: TimeInterval = ToastManager.shared.duration,
                             position: ToastDisplay = ToastDisplay.default, title: String? = nil, image: UIImage? = nil,
                             style: ToastStyle = ToastManager.shared.style, completion: ((_ didTap: Bool) -> Void)? = nil) {
        do {
            let toast = try toastViewForMessage(message, title: title, image: image, style: style)
            showToast(toast, duration: duration, position: position, completion: completion)
        } catch ToastError.missingParameters {
            print("Error: message, title, and image are all nil")
        } catch {}
    }

    public func showToast(_ toast: UIView, duration: TimeInterval = ToastManager.shared.duration,
                          position: ToastDisplay = ToastDisplay.aboveToolbar, completion: ((_ didTap: Bool) -> Void)? = nil) {
        let point = position.centerPoint(forToast: toast, inSuperview: self)
        showToast(toast, duration: duration, point: point, completion: completion)
    }

    private enum ToastError: Error {
        case missingParameters
    }
}

fileprivate extension UIView {
    fileprivate var csSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
}
