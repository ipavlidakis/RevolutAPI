//
//  ListenerProtocol.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

typealias UnsubscribeListener = () -> Void

protocol ListenerProtocol {

    var identifier: UUID { get }

    func stateUpdated()
}

extension ListenerProtocol where Self: Equatable {

    static func ==(
        lhs: ListenerProtocol,
        rhs: ListenerProtocol) -> Bool {

        return lhs.identifier == rhs.identifier
    }
}

extension ListenerProtocol where Self: Hashable {

    var hashValue: Int { return identifier.hashValue }
}
