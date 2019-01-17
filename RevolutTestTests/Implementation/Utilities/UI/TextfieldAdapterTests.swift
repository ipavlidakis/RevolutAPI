//
//  TextfieldAdapterTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import RevolutTest

final class TextfieldAdapterTests: XCTestCase {

    private var viewModel: CurrencyPrice! = CurrencyPrice(code: "Code", description: "Description", price: 100)
    private var textFieldAdapter: TextfieldAdapter!

    override func setUp() {

        super.setUp()
    }

    override func tearDown() {

        viewModel = nil
        textFieldAdapter = nil

        super.tearDown()
    }
}

extension TextfieldAdapterTests {

    // MARK: - textFieldDidBeginEditing

    func test_textFieldDidBeginEditing_textFieldDidBeginEditingBlockInvoked() {

        var blockInvoked = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldDidBeginEditingBlock: { blockInvoked = true})

        textFieldAdapter.textFieldDidBeginEditing(UITextField())

        XCTAssertTrue(blockInvoked)
    }

    // MARK: - textFieldDidEndEditing

    func test_textFieldDidEndEditing_textFieldDidEndEditingBlockInvoked() {

        var blockInvoked = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldDidEndEditingBlock: { blockInvoked = true})

        textFieldAdapter.textFieldDidEndEditing(UITextField())

        XCTAssertTrue(blockInvoked)
    }

    // MARK: - textFieldDidEndEditing:reason

    func test_textFieldDidEndEditingWithReson_textFieldDidEndEditingBlockInvoked() {

        var blockInvoked = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldDidEndEditingBlock: { blockInvoked = true})

        textFieldAdapter.textFieldDidEndEditing(
            UITextField(),
            reason: .committed)

        XCTAssertTrue(blockInvoked)
    }

    // MARK: - textFieldShouldClear

    func test_textFieldShouldClear_textFieldShouldClearBlockInvoked() {

        var blockInvoked = false
        let stubbedResult = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldShouldClearBlock: {

                blockInvoked = true
                return stubbedResult
        })

        let actualResult = textFieldAdapter.textFieldShouldClear(UITextField())

        XCTAssertTrue(blockInvoked)
        XCTAssertEqual(actualResult, stubbedResult)
    }

    // MARK: - textFieldShouldReturn

    func test_textFieldShouldReturn_textFieldShouldReturnBlockInvoked() {

        var blockInvoked = false
        let stubbedResult = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldShouldReturnBlock: {

                blockInvoked = true
                return stubbedResult
        })

        let actualResult = textFieldAdapter.textFieldShouldReturn(UITextField())

        XCTAssertTrue(blockInvoked)
        XCTAssertEqual(actualResult, stubbedResult)
    }

    // MARK: - textFieldShouldBeginEditing

    func test_textFieldShouldBeginEditing_textFieldShouldBeginEditingBlockInvoked() {

        var blockInvoked = false
        let stubbedResult = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldShouldBeginEditingBlock: {

                blockInvoked = true
                return stubbedResult
        })

        let actualResult = textFieldAdapter.textFieldShouldBeginEditing(UITextField())

        XCTAssertTrue(blockInvoked)
        XCTAssertEqual(actualResult, stubbedResult)
    }

    // MARK: - textFieldShouldEndEditing

    func test_textFieldShouldEndEditing_textFieldShouldEndEditingBlockInvoked() {

        var blockInvoked = false
        let stubbedResult = false
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldShouldEndEditingBlock: {

                blockInvoked = true
                return stubbedResult
        })

        let actualResult = textFieldAdapter.textFieldShouldEndEditing(UITextField())

        XCTAssertTrue(blockInvoked)
        XCTAssertEqual(actualResult, stubbedResult)
    }

    // MARK: - shouldChangeCharactersIn

    func test_shouldChangeCharactersIn_textFieldShouldChangeBlockBlockInvoked() {

        var blockInvoked: (textField: UITextField, newText: String, viewModel: CurrencyPrice)?
        let stubbedResult = false

        let textField = UITextField()
        textField.text = "a"
        textFieldAdapter = TextfieldAdapter(
            viewModel: viewModel,
            textFieldShouldChangeBlock: { textField, newText, viewModel in

                blockInvoked = (textField: textField, newText: newText, viewModel: viewModel)
                return stubbedResult
        })

        let actualResult = textFieldAdapter.textField(
            textField,
            shouldChangeCharactersIn: NSRange(location: 0, length: 1),
            replacementString: "b")

        XCTAssertEqual(actualResult, stubbedResult)
        XCTAssertEqual(textField, blockInvoked?.textField)
        XCTAssertEqual("b", blockInvoked?.newText)
        XCTAssertEqual(viewModel, blockInvoked?.viewModel)
    }
}
