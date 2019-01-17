//
//  NumberFormatter+RevolutTest.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension NumberFormatter {

    static func projectNumberFormatter() -> NumberFormatter {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ""

        return formatter
    }
}
