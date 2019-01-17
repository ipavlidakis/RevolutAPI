//
//  StubStore.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubStore {

    var stubState = AppState.initial

    private(set) var dispatchCalledWithActions: [ActionProtocol] = []

    private(set) var subscribeCalledWithListener: ListenerProtocol?
    var subscribeStubResult: UnsubscribeListener! = {  }
}

extension StubStore: StoreProtocol {

    var state: AppState {

        return stubState
    }

    func dispatch(
        _ action: ActionProtocol) {

        dispatchCalledWithActions.append(action)
    }

    func subscribe(
        _ listener: ListenerProtocol) -> UnsubscribeListener {

        subscribeCalledWithListener = listener

        let result: UnsubscribeListener = subscribeStubResult
        subscribeStubResult = nil

        return result
    }
}
