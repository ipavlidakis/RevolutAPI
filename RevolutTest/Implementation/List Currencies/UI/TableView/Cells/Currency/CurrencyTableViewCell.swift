//
//  CurrencyTableViewCell.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "CurrencyTableViewCell"

    @IBOutlet weak var currencyImageView: CircularUIImageView!
    @IBOutlet weak var currencyTitle: UILabel!
    @IBOutlet weak var currencyLongTitle: UILabel!
    @IBOutlet weak var currencyPriceTextField: UITextField!
    @IBOutlet weak var currencyPriceUnderline: UIView!
}
