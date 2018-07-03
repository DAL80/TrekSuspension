//
//  String+Ext.swift
//  TrekSuspension
//
//  Created by Darren Larson on 6/8/18.
//  Copyright © 2018 Darren Larson. All rights reserved.
//

import Foundation

extension String {
    func localized(tableName:String? = nil, withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, tableName: tableName, value: "<\(self)>", comment: comment ?? "")
    }
}
