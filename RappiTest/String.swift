//
//  String.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
