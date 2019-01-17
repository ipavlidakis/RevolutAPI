//
//  ReducerProtocol.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

typealias Reducer = (
    _ state: AppState,
    _ action: ActionProtocol) -> AppState
