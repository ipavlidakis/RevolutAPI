//
//  String+toNumber.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension String {

    func toNumber(
        _ numberFormatter: NumberFormatter) -> NSNumber? {

        guard let parsedNumber = numberFormatter.number(from: self) else {

            return nil
        }

        return parsedNumber
    }
}
