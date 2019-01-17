//
//  StubUITableView.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class StubUITableView: UITableView {

    private(set) var dequeueReusableCellWasCalledWithIdentifier: String?
    var dequeueReusableCellStubResult: UITableViewCell?

    private(set) var addSubviewWasCalledWithView: UIView?
    var callSuperAddSubview = true

    private(set) var cellForRowWithIndexPath: IndexPath?
    var cellForRowStubResult: UITableViewCell?

    private(set) var endEditingWasCalledWithForce: Bool?
    var endEditingStubResult: Bool = true

    private(set) var registerNibWasCalled: (nib: UINib?, reuseIdentifier: String)?

    private(set) var reloadDataWasCalled: Bool?
}

extension StubUITableView {

    override func dequeueReusableCell(
        withIdentifier identifier: String) -> UITableViewCell? {

        dequeueReusableCellWasCalledWithIdentifier = identifier

        return dequeueReusableCellStubResult
    }

    override func addSubview(
        _ view: UIView) {

        addSubviewWasCalledWithView = view

        guard callSuperAddSubview else { return }

        super.addSubview(view)
    }

    override func cellForRow(
        at indexPath: IndexPath) -> UITableViewCell? {

        cellForRowWithIndexPath = indexPath

        return cellForRowStubResult
    }

    override func endEditing(
        _ force: Bool) -> Bool {

        endEditingWasCalledWithForce = force

        return endEditingStubResult
    }

    override func register(
        _ nib: UINib?,
        forCellReuseIdentifier identifier: String) {

        registerNibWasCalled = (nib: nib, reuseIdentifier: identifier)
    }

    override func reloadData() {

        reloadDataWasCalled = true
    }
}
