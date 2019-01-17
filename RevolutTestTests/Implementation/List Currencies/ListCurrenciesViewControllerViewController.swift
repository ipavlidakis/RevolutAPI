//
//  ListCurrenciesViewControllerViewController.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class ListCurrenciesViewControllerViewControllerTests: XCTestCase {

    private var stubTableViewAdapter: StubTableViewAdapter! = StubTableViewAdapter()

    override func tearDown() {

        stubTableViewAdapter = nil
        super.tearDown()
    }

    // MARK: - viewDidLoad

    func test_viewDidLoad_tableViewWasConfiguredCorrectly() {

        let viewController = ListCurrenciesViewController()
        viewController.tableViewAdapter = stubTableViewAdapter

        viewController.loadViewIfNeeded()

        XCTAssertNotNil(viewController.tableView.tableFooterView)
        XCTAssertEqual(viewController.tableView.separatorStyle, .none)
        XCTAssertEqual(viewController.tableView.keyboardDismissMode, .onDrag)
    }

    func test_viewDidLoad_configureWasCalledOnTableViewAdapter() {

        let viewController = ListCurrenciesViewController()
        viewController.tableViewAdapter = stubTableViewAdapter

        viewController.loadViewIfNeeded()

        XCTAssertEqual(stubTableViewAdapter.configureWasCalledWithTableView, viewController.tableView)
    }
}
