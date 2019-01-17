//
//  CurrencyPrice.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct CurrencyPrice: Equatable {

    let code: String
    let description: String
    let price: Double
}

extension CurrencyPrice: Hashable {

    var hasValue: Int {

        return code.hashValue
            ^ price.hashValue
    }
}
