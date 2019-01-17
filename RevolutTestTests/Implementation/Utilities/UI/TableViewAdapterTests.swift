//
//  TableViewAdapterTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import RevolutTest

final class TableViewAdapterTests: XCTestCase {

    private var items: [CurrencyPrice]!
    private var stubCellConfigurator: StubCurrencyTableViewCellConfigurator! = StubCurrencyTableViewCellConfigurator()
    private var stubNumberFormatter: StubNumberFormatter! = StubNumberFormatter()
    private var stubTextfieldDelegate: StubUITextFieldDelegate! = StubUITextFieldDelegate()
    private var stubTableView: StubUITableView! = StubUITableView()
    private var stubTableViewAdapterDelegate: StubTableViewAdapterDelegate! = StubTableViewAdapterDelegate()
    private var adapter: TableViewAdapter!

    override func setUp() {

        super.setUp()

        items = (0..<10).map { CurrencyPrice(
            code: "\($0)",
            description: "\($0)",
            price: Double($0)) }

        adapter = TableViewAdapter(
            cellConfigurator: stubCellConfigurator,
            textfieldDelegate: stubTextfieldDelegate,
            numberFormatter: stubNumberFormatter)
    }

    override func tearDown() {

        items = nil
        stubCellConfigurator = nil
        stubNumberFormatter = nil
        stubTextfieldDelegate = nil
        stubTableView = nil
        stubTableViewAdapterDelegate = nil
        adapter = nil

        super.tearDown()
    }
}

extension TableViewAdapterTests {

    // MARK: - UITableViewDataSource
    // MARK: numberOfRowsInSection

    func test_numberOfRowsInSection_returnsNumberOfItems() {

        let expected = items.count
        adapter.update(
            with: items,
            tableView: stubTableView)

        let actual = adapter.tableView(
            stubTableView,
            numberOfRowsInSection: 0)

        XCTAssertEqual(actual, expected)
    }

    // MARK: cellForRowAt

    func test_cellForRowAt_cellIsCurrencyTableViewCellIndexPathIsValid_cellConfiguratorWasCalledWithExpectedValues() {

        let stubCell = CurrencyTableViewCell()
        stubTableView.dequeueReusableCellStubResult = stubCell
        let indexPath = IndexPath(row: 0, section: 0)
        let viewModel = items.first
        adapter.update(with: items, tableView: stubTableView)

        _ = adapter.tableView(
            stubTableView,
            cellForRowAt: indexPath)

        XCTAssertEqual(stubCellConfigurator.configureWasCalled?.cell, stubCell)
        XCTAssertEqual(stubCellConfigurator.configureWasCalled?.viewModel, viewModel)
    }

    func test_cellForRowAt_cellIsCurrencyTableViewCellIndexPathIsValid_returnsExpectedCell() {

        let stubCell = CurrencyTableViewCell()
        stubTableView.dequeueReusableCellStubResult = stubCell
        let indexPath = IndexPath(row: 0, section: 0)
        adapter.update(with: items, tableView: stubTableView)

        let result = adapter.tableView(
            stubTableView,
            cellForRowAt: indexPath)

        XCTAssertEqual(result, stubCell)
    }
}

extension TableViewAdapterTests {

    // MARK: - UITableViewDelegate
    // MARK: didSelectRowAt

    func test_didSelectRowAt_addsExpectedViewInTableView() {

        let stubCell = Bundle.main.loadNibNamed("CurrencyTableViewCell", owner: nil, options: nil)!.first as! CurrencyTableViewCell
        stubTableView.cellForRowStubResult = stubCell
        stubTableView.callSuperAddSubview = false
        let indexPath = IndexPath(row: 0, section: 0)
        adapter.update(with: items, tableView: stubTableView)

        adapter.tableView(
            stubTableView,
            didSelectRowAt: indexPath)

        XCTAssertEqual(stubTableView.cellForRowWithIndexPath, indexPath)
        XCTAssertNotNil(stubTableView.addSubviewWasCalledWithView)
        XCTAssert(stubTableView.addSubviewWasCalledWithView?.superview is CurrencyTableViewCell)
    }

    func test_didSelectRowAt_addsExpectedViewInCorrectPosition() {

        let stubCell = Bundle.main.loadNibNamed("CurrencyTableViewCell", owner: nil, options: nil)!.first as! CurrencyTableViewCell
        stubTableView.cellForRowStubResult = stubCell
        let expectedFrame = CGRect(x: 101, y: 0, width: 101, height: 102)
        stubCell.frame = expectedFrame
        let indexPath = IndexPath(row: 0, section: 0)
        adapter.update(with: items, tableView: stubTableView)

        adapter.tableView(
            stubTableView,
            didSelectRowAt: indexPath)

        XCTAssertEqual(stubTableView.addSubviewWasCalledWithView?.frame, expectedFrame)
    }

    func test_didSelectRowAt_willStartEditingInvokedOnDelegate() {

        let stubCell = Bundle.main.loadNibNamed("CurrencyTableViewCell", owner: nil, options: nil)!.first as! CurrencyTableViewCell
        stubTableView.cellForRowStubResult = stubCell
        let indexPath = IndexPath(row: 0, section: 0)
        adapter.update(with: items, tableView: stubTableView)
        adapter.delegate = stubTableViewAdapterDelegate

        adapter.tableView(
            stubTableView,
            didSelectRowAt: indexPath)

        XCTAssert(stubTableViewAdapterDelegate.willStartEditingWasCalled ?? false)
    }

    // MARK: heightForRowAt

    func test_heightForRowAt_returnsExpectedValue() {

        let expected = UITableView.automaticDimension

        let actual = adapter.tableView(
            stubTableView,
            heightForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(actual, expected)
    }
}

extension TableViewAdapterTests {

    // MARK: - UIScrollViewDelegate
    // MARK: scrollViewWillBeginDragging

    func test_scrollViewWillBeginDragging_endEditingWasCalledOnMockedView() {

        let stubCell = Bundle.main.loadNibNamed("CurrencyTableViewCell", owner: nil, options: nil)!.first as! CurrencyTableViewCell
        stubTableView.cellForRowStubResult = stubCell
        let indexPath = IndexPath(row: 0, section: 0)
        adapter.update(with: items, tableView: stubTableView)
        adapter.tableView(stubTableView, didSelectRowAt: indexPath)

        adapter.scrollViewWillBeginDragging(
            stubTableView)

        XCTAssertNotNil(stubTableView.endEditingWasCalledWithForce)
    }
}

extension TableViewAdapterTests {

    // MARK: configure

    func test_configure_hasCorrectDatasource() {

        adapter.configure(
            tableView: stubTableView)

        XCTAssertTrue(stubTableView.dataSource === adapter)
    }

    func test_configure_hasCorrectDelegate() {

        adapter.configure(
            tableView: stubTableView)

        XCTAssertTrue(stubTableView.delegate === adapter)
    }

    func test_configure_registerNibWasCalledWithExpectedIdentifier() {

        let expectedIdentifier = "CurrencyTableViewCell"

        adapter.configure(
            tableView: stubTableView)

        XCTAssertNotNil(stubTableView.registerNibWasCalled?.nib)
        XCTAssertEqual(stubTableView.registerNibWasCalled?.reuseIdentifier, expectedIdentifier)
    }

    // MARK: update

    func test_update_reloadDataWasCalled() {

        adapter.update(
            with: items,
            tableView: stubTableView)

        XCTAssert(stubTableView.reloadDataWasCalled ?? false)
    }

    func test_update_numberOfItemsReturnsNewCount() {

        adapter.update(
            with: [],
            tableView: stubTableView)

        XCTAssertEqual(stubTableView.numberOfRows(inSection: 0), 0)
    }
}
