//
//  StoreProtocol.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol StoreProtocol {

    var state: AppState { get }

    func dispatch(
        _ action: ActionProtocol)

    func subscribe(
        _ listener: ListenerProtocol) -> UnsubscribeListener
}
