//
//  CurrencyTableViewCellConfiguratorTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class CurrencyTableViewCellConfiguratorTests: XCTestCase {

    private lazy var cell: CurrencyTableViewCell! =  Bundle.main.loadNibNamed("CurrencyTableViewCell", owner: nil, options: nil)!.first as! CurrencyTableViewCell
    private var viewModel: CurrencyPrice! = CurrencyPrice(code: "Code", description: "Description", price: 10)
    private var configurator: CurrencyTableViewCellConfigurator! = CurrencyTableViewCellConfigurator()

    override func setUp() {

        super.setUp()

        configurator.configure(cell, viewModel: viewModel)
    }

    override func tearDown() {

        cell = nil
        viewModel = nil
        configurator = nil

        super.tearDown()
    }
}

extension CurrencyTableViewCellConfiguratorTests {

    // MARK: - configure

    func test_configure_selectionStyleCorrectly() {

        XCTAssertEqual(cell.selectionStyle, .none)
    }

    func test_configure_imageViewCorrectly() {

        XCTAssertEqual(cell.currencyImageView.backgroundColor, .gray)
    }

    func test_configure_titleCorrectly() {

        XCTAssertEqual(cell.currencyTitle.font, UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize))
        XCTAssertEqual(cell.currencyTitle.textColor, .black)
        XCTAssertEqual(cell.currencyTitle.text!, "Code")
        XCTAssertEqual(cell.currencyTitle.numberOfLines, 1)
    }

    func test_configure_longTitleCorrectly() {

        XCTAssertEqual(cell.currencyLongTitle.font, UIFont.preferredFont(forTextStyle: .caption1))
        XCTAssertEqual(cell.currencyLongTitle.textColor, .lightGray)
        XCTAssertEqual(cell.currencyLongTitle.text!, "Description")
        XCTAssertEqual(cell.currencyLongTitle.numberOfLines, 1)
    }

    func test_configure_textFieldCorrectly() {

        XCTAssertEqual(cell.currencyPriceTextField.font, UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize))
        XCTAssertEqual(cell.currencyPriceTextField.textColor, .black)
        XCTAssertEqual(cell.currencyPriceTextField.text, "10")
        XCTAssertEqual(cell.currencyPriceTextField.keyboardType, .default)
        XCTAssertFalse(cell.currencyPriceTextField.isUserInteractionEnabled)
    }

    func test_configure_priceUnderlineCorrectly() {

        XCTAssertEqual(cell.currencyPriceUnderline.backgroundColor, .lightGray)
    }
}
