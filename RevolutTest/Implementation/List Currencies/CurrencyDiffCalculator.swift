//
//  CurrencyDiffCalculator.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

typealias CurrencyDiffUpdateBlock = (_ diffPercentage: Double) -> Void
typealias CurrencyDiffCompletedBlock = () -> Void

final class CurrencyDiffCalculator: NSObject {

    private let initialViewModel: CurrencyPrice
    private let textField: UITextField
    private let numberFormatter: NumberFormatter
    private let updateBlock: CurrencyDiffUpdateBlock
    private let completedBlock: CurrencyDiffCompletedBlock

    convenience init(
        initialViewModel: CurrencyPrice,
        textField: UITextField,
        updateBlock: @escaping CurrencyDiffUpdateBlock,
        completedBlock: @escaping CurrencyDiffCompletedBlock) {

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 3

        self.init(
            initialViewModel: initialViewModel,
            textField: textField,
            numberFormatter: numberFormatter,
            updateBlock: updateBlock,
            completedBlock: completedBlock)
    }

    init(initialViewModel: CurrencyPrice,
         textField: UITextField,
         numberFormatter: NumberFormatter,
         updateBlock: @escaping CurrencyDiffUpdateBlock,
         completedBlock: @escaping CurrencyDiffCompletedBlock) {

        self.initialViewModel = initialViewModel
        self.textField = textField
        self.numberFormatter = numberFormatter
        self.updateBlock = updateBlock
        self.completedBlock = completedBlock

        super.init()

        textField.delegate = self
    }
}

private extension CurrencyDiffCalculator {

    func calculateDiff(
        with newValue: Double) {

        let currentValue = initialViewModel.price

        let diff = (currentValue - newValue) * 100

        print("Diff: \(diff)")

        updateBlock(diff)
    }
}

extension CurrencyDiffCalculator: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

        let newValue: NSNumber = {

            guard let text = textField.text else {

                return string.toNumber(numberFormatter) ?? 0
            }

            return NSString(string: text)
                .replacingCharacters(in: range, with: string)
                .toNumber(numberFormatter) ?? 0
        }()

        calculateDiff(with: newValue.doubleValue)

        textField.text = numberFormatter.string(from: newValue)

        return false
    }

    func textFieldShouldReturn(
        _ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        completedBlock()

        return true
    }

    func textFieldShouldEndEditing(
        _ textField: UITextField) -> Bool {

        completedBlock()

        return true
    }
}
