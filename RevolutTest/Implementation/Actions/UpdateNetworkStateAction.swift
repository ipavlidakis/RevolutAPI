//
//  UpdateNetworkStateAction.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct UpdateNetworkStateAction: ActionProtocol {

    let state: AppState.NetworkState.State
}
