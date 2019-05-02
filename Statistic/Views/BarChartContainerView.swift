//
//  BarChartContainerView.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

class BarChartContainerView: UIView {

    lazy var titleLabel: UILabel = {
        let _title = UILabel(text: "Focus Time", textColor: .black, font: UIFont.systemFont(ofSize: 18, weight: .bold))
        return _title
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    fileprivate func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.createShadow(opacity: 0.4, offset: CGSize(width: 0, height: 8), radius: 8, color: .lightGray)

        let stack = UIStackView(arrangedSubviews: [titleLabel])
        stack.axis = .vertical

        self.addSubview(stack)
        stack.anchors(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
    }
}
