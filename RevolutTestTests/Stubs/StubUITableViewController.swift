//
//  StubUITableViewController.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

@testable import RevolutTest

final class StubUITableViewController {

    var stubTableView: StubUITableView = StubUITableView()
    var stubNavigationItem: UINavigationItem = UINavigationItem()
}

extension StubUITableViewController: TableViewProviding {

    var tableView: UITableView! {

        return stubTableView
    }

    var navigationItem: UINavigationItem {

        return stubNavigationItem
    }
}
