//
//  StubTableViewAdapter.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

@testable import RevolutTest

final class StubTableViewAdapter {

    var delegate: TableViewAdapterDelegate?

    private(set) var updateWasCalled: (items: [CurrencyPrice], tableView: UITableView)?

    private(set) var configureWasCalledWithTableView: UITableView?
}

extension StubTableViewAdapter: TableViewAdapterProtocol {

    func update(
        with items: [CurrencyPrice],
        tableView: UITableView) {

        updateWasCalled = (items: items, tableView: tableView)
    }

    func configure(
        tableView: UITableView) {

        configureWasCalledWithTableView = tableView
    }
}
