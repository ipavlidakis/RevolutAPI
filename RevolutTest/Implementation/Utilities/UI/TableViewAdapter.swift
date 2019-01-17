//
//  TableViewAdapter.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewAdapterProtocol {

    var delegate: TableViewAdapterDelegate? { get set }

    func update(
        with items: [CurrencyPrice],
        tableView: UITableView)

    func configure(
        tableView: UITableView)
}

protocol TableViewAdapterDelegate: class {

    func willStartEditing()

    func didChangeValue(
        to: Double,
        for viewModel: CurrencyPrice)

    func willStopEditing()
}

final class TableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    private var items: [CurrencyPrice] = []
    private let cellConfigurator: CurrencyTableViewCellConfiguring
    private let numberFormatter: NumberFormatter

    weak var delegate: TableViewAdapterDelegate?

    private var textfieldDelegate: UITextFieldDelegate?
    private var mockView: UIView?

    convenience override init() {

        let cellConfigurator = CurrencyTableViewCellConfigurator()
        let numberFormatter = NumberFormatter.projectNumberFormatter()

        self.init(
            cellConfigurator: cellConfigurator,
            textfieldDelegate: nil,
            numberFormatter: numberFormatter)
    }

    init(cellConfigurator: CurrencyTableViewCellConfiguring,
         textfieldDelegate: UITextFieldDelegate?,
         numberFormatter: NumberFormatter) {

        self.cellConfigurator = cellConfigurator
        self.numberFormatter = numberFormatter
        self.textfieldDelegate = textfieldDelegate

        super.init()
    }

    // MARK: - UITableViewDataSource

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier) as? CurrencyTableViewCell else {

                fatalError("Invalid reuse identifier")
        }

        guard indexPath.row < items.count else {

            assert(false, "Invalid indexpath detected")

            return cell
        }

        let viewModel = items[indexPath.row]

        cellConfigurator.configure(
            cell,
            viewModel: viewModel)

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyTableViewCell else {

            return
        }

        let viewModel = items[indexPath.row]

        let copiedView = createEditableCell(
            copy: cell.currencyPriceTextField,
            viewModel: viewModel)

        tableView.addSubview(copiedView)
        copiedView.frame = cell.frame

        delegate?.willStartEditing()

        mockView = copiedView
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView) {

        mockView?.superview?.endEditing(true)
    }
}

extension TableViewAdapter: TableViewAdapterProtocol {

    func configure(
        tableView: UITableView) {

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            UINib(nibName: CurrencyTableViewCell.reuseIdentifier, bundle: Bundle.main),
            forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
    }

    func update(
        with items: [CurrencyPrice],
        tableView: UITableView) {

        self.items = items

        tableView.reloadData()
    }
}

private extension TableViewAdapter {

    func shouldChange(
        _ textField: UITextField,
        _ newString: String,
        _ viewModel: CurrencyPrice) -> Bool {

        let notEmptyString = (newString.isEmpty ? "0" : newString)

        guard let nsNumberValue = numberFormatter.number(from: notEmptyString) else {

            print("\(newString) it's not a valid number")
            return false
        }

        delegate?.didChangeValue(
            to: nsNumberValue.doubleValue,
            for: viewModel)

        let numberComponents: (wholePart: Double, fractionalPart: Double) = modf(nsNumberValue.doubleValue)

        if numberComponents.fractionalPart > 0 || notEmptyString.hasSuffix(".") {

            textField.text = notEmptyString
        } else {

            textField.text = numberFormatter.string(from: nsNumberValue)
        }

        return false
    }

    func createEditableCell(
        copy textfield: UITextField,
        viewModel: CurrencyPrice) -> UIView {

        let cell = Bundle.main.loadNibNamed(
            String(describing: CurrencyTableViewCell.self),
            owner: nil, options: nil)?.first as! CurrencyTableViewCell

        cellConfigurator.configure(
            cell,
            viewModel: viewModel)
        cell.currencyPriceTextField.isUserInteractionEnabled = true
        cell.contentView.backgroundColor = .white

        mockView?.endEditing(true)
        textfieldDelegate = makeTextfieldAdapter(for: viewModel)
        cell.currencyPriceTextField.delegate = textfieldDelegate

        cell.currencyPriceTextField.becomeFirstResponder()

        return cell.contentView
    }

    func makeTextfieldAdapter(
        for viewModel: CurrencyPrice) -> TextfieldAdapter {

        return TextfieldAdapter(
            viewModel: viewModel,
            textFieldDidBeginEditingBlock: { [weak self] in

                self?.delegate?.willStartEditing()
            },
            textFieldDidEndEditingBlock: { [weak self] in

                self?.mockView?.endEditing(true)
                self?.mockView?.removeFromSuperview()
                self?.delegate?.willStopEditing()
            },
            textFieldShouldChangeBlock: shouldChange)
    }
}
