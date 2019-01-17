//
//  ListCurrenciesViewController.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class ListCurrenciesViewController: UITableViewController {

    var tableViewAdapter: TableViewAdapterProtocol!

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init() {

        super.init(nibName: nil, bundle: nil)
    }
}

extension ListCurrenciesViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Currencies"

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag

        tableViewAdapter.configure(
            tableView: tableView)
    }
}
