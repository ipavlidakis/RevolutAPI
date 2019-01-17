//
//  CircularUIImageView.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class CircularUIImageView: UIImageView {

    override func layoutSubviews() {

        layer.cornerRadius = frame.height / 2
        super.layoutSubviews()
    }
}
