//
//  StubCurrencyTableViewCellConfigurator.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubCurrencyTableViewCellConfigurator {

    private(set) var configureWasCalled: (cell: CurrencyTableViewCell, viewModel: CurrencyPrice)?
}

extension StubCurrencyTableViewCellConfigurator: CurrencyTableViewCellConfiguring {

    func configure(
        _ cell: CurrencyTableViewCell,
        viewModel: CurrencyPrice) {

        configureWasCalled = (cell: cell, viewModel: viewModel)
    }
}
