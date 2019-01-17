//
//  StubTableViewAdapterDelegate.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubTableViewAdapterDelegate {

    private(set) var willStartEditingWasCalled: Bool?

    private(set) var didChangeValueWasCalled: (to: Double, viewModel: CurrencyPrice)?

    private(set) var willStopEditingWasCalled: Bool?
}

extension StubTableViewAdapterDelegate: TableViewAdapterDelegate {

    func willStartEditing() {

        willStartEditingWasCalled = true
    }

    func didChangeValue(
        to: Double,
        for viewModel: CurrencyPrice) {

        didChangeValueWasCalled = (to: to, viewModel: viewModel)
    }

    func willStopEditing() {

        willStopEditingWasCalled = true
    }
}
