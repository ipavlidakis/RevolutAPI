//
//  TextfieldAdapter.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

typealias TextfiedlAdapterBlock = () -> Swift.Void
typealias TextfiedlAdapterBoolBlock = () -> Bool
typealias TextfiedlAdapterChangeBlock = (_ textField: UITextField, _ newText: String, _ viewModel: CurrencyPrice) -> Bool

final class TextfieldAdapter: NSObject {

    private let viewModel: CurrencyPrice

    private let textFieldDidBeginEditingBlock: TextfiedlAdapterBlock?
    private let textFieldDidEndEditingBlock: TextfiedlAdapterBlock?

    private let textFieldShouldClearBlock: TextfiedlAdapterBoolBlock?
    private let textFieldShouldReturnBlock: TextfiedlAdapterBoolBlock?
    private let textFieldShouldBeginEditingBlock: TextfiedlAdapterBoolBlock?
    private let textFieldShouldEndEditingBlock: TextfiedlAdapterBoolBlock?

    private let textFieldShouldChangeBlock: TextfiedlAdapterChangeBlock?

    init(viewModel: CurrencyPrice,
         textFieldDidBeginEditingBlock: TextfiedlAdapterBlock? = nil,
         textFieldDidEndEditingBlock: TextfiedlAdapterBlock? = nil,
         textFieldShouldClearBlock: TextfiedlAdapterBoolBlock? = nil,
         textFieldShouldReturnBlock: TextfiedlAdapterBoolBlock? = nil,
         textFieldShouldBeginEditingBlock: TextfiedlAdapterBoolBlock? = nil,
         textFieldShouldEndEditingBlock: TextfiedlAdapterBoolBlock? = nil,
         textFieldShouldChangeBlock: TextfiedlAdapterChangeBlock? = nil) {

        self.viewModel = viewModel

        self.textFieldDidBeginEditingBlock = textFieldDidBeginEditingBlock
        self.textFieldDidEndEditingBlock = textFieldDidEndEditingBlock

        self.textFieldShouldClearBlock = textFieldShouldClearBlock
        self.textFieldShouldReturnBlock = textFieldShouldReturnBlock
        self.textFieldShouldBeginEditingBlock = textFieldShouldBeginEditingBlock
        self.textFieldShouldEndEditingBlock = textFieldShouldEndEditingBlock

        self.textFieldShouldChangeBlock = textFieldShouldChangeBlock

        super.init()
    }
}

extension TextfieldAdapter: UITextFieldDelegate {

    func textFieldDidBeginEditing(
        _ textField: UITextField) {

        textFieldDidBeginEditingBlock?()
    }

    func textFieldDidEndEditing(
        _ textField: UITextField) {

        textFieldDidEndEditingBlock?()
    }

    func textFieldDidEndEditing(
        _ textField: UITextField,
        reason: UITextField.DidEndEditingReason) {

        textFieldDidEndEditingBlock?()
    }

    func textFieldShouldClear(
        _ textField: UITextField) -> Bool {

        return textFieldShouldClearBlock?() ?? true
    }

    func textFieldShouldReturn(
        _ textField: UITextField) -> Bool {

        return textFieldShouldReturnBlock?() ?? true
    }

    func textFieldShouldBeginEditing(
        _ textField: UITextField) -> Bool {

        return textFieldShouldBeginEditingBlock?() ?? true
    }

    func textFieldShouldEndEditing(
        _ textField: UITextField) -> Bool {

        return textFieldShouldEndEditingBlock?() ?? true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

        let newText = NSString(string: textField.text ?? "")
            .replacingCharacters(in: range, with: string)

        return textFieldShouldChangeBlock?(textField, newText, viewModel) ?? true
    }
}
