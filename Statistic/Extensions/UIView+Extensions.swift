//
//  UIView+Extensions.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

extension UIView {
    func anchors(
            top: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
            leading: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
            trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
            bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
            size: CGSize = CGSize(width: 0, height: 0),
            padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            ){

        self.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }

        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func createShadow(opacity: Float, offset: CGSize = CGSize(width: 0, height: 0), radius: CGFloat, color: UIColor) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
    }
}
