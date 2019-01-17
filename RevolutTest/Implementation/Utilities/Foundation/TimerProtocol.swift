//
//  TimerProtocol.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol TimerProtocol {

    func fire()

    func invalidate()
}

extension Timer: TimerProtocol {}
