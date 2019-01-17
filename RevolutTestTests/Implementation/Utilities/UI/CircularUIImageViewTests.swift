//
//  CircularUIImageViewTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import RevolutTest

final class CircularUIImageViewTests: XCTestCase {

    // MARK: - layoutSubviews

    func test_layoutSubviews_updatesCornerRadius() {

        let subject = CircularUIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        subject.layoutSubviews()

        XCTAssertEqual(subject.layer.cornerRadius, 5)
    }

}
