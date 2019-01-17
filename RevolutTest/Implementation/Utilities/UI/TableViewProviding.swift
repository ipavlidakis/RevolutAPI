//
//  TableViewProviding.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewProviding: class {

    var tableView: UITableView! { get }

    var navigationItem: UINavigationItem { get }
}

extension UITableViewController: TableViewProviding { }
