//
//  UILabel.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor = .white, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
    }
}
