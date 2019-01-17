//
//  MiddlewareProtocol.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol MiddlewareProtocol {

    func apply(
        _ state: AppState,
        _ action: ActionProtocol)
}
