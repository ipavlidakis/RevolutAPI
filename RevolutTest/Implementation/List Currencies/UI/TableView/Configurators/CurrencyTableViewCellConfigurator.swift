//
//  CurrencyTableViewCellConfigurator.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyTableViewCellConfiguring {

    func configure(
        _ cell: CurrencyTableViewCell,
        viewModel: CurrencyPrice)
}

final class CurrencyTableViewCellConfigurator: CurrencyTableViewCellConfiguring {

    private lazy var currencyTitle = UIFont.preferredFont(forTextStyle: .title3)
    private lazy var currencyLongTitleFont = UIFont.preferredFont(forTextStyle: .caption1)
    private lazy var currencyPriceFont = UIFont.preferredFont(forTextStyle: .title1)
    private lazy var numberFormatter: NumberFormatter = NumberFormatter.projectNumberFormatter()

    func configure(
        _ cell: CurrencyTableViewCell,
        viewModel: CurrencyPrice) {

        cell.selectionStyle = .none
        cell.currencyImageView.backgroundColor = UIColor.gray

        cell.currencyTitle.font = UIFont.boldSystemFont(ofSize: currencyTitle.pointSize)
        cell.currencyTitle.textColor = UIColor.black
        cell.currencyTitle.text = viewModel.code.capitalized
        cell.currencyTitle.numberOfLines = 1

        cell.currencyLongTitle.font = currencyLongTitleFont
        cell.currencyLongTitle.textColor = UIColor.lightGray
        cell.currencyLongTitle.text = viewModel.description
        cell.currencyLongTitle.numberOfLines = 1

        cell.currencyPriceTextField.font = UIFont.boldSystemFont(ofSize: currencyPriceFont.pointSize)
        cell.currencyPriceTextField.textColor = UIColor.black
        cell.currencyPriceTextField.text = numberFormatter.string(from: NSNumber(value: viewModel.price))
        cell.currencyPriceTextField.keyboardType = .default
        cell.currencyPriceTextField.isUserInteractionEnabled = false

        cell.currencyPriceUnderline.backgroundColor = UIColor.lightGray
    }
}
