//
//  ViewController.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let _headerGradient = CAGradientLayer()

    let _barChartView = BarChartContainerView()

    var bars = [Bar]()

    lazy var headerView: UIView = {
        let _headerView = UIView()
        _headerView.createShadow(opacity: 0.4, offset: CGSize(width: 0, height: 5), radius: 8, color: #colorLiteral(red: 0.3092674613, green: 0.3397194743, blue: 0.8171567321, alpha: 1))
        _headerGradient.colors = [#colorLiteral(red: 0.2301672995, green: 0.6835840344, blue: 0.8974104524, alpha: 1).cgColor, #colorLiteral(red: 0.3092674613, green: 0.3397194743, blue: 0.8171567321, alpha: 1).cgColor]
        _headerGradient.startPoint = CGPoint(x: 1, y: 0)
        _headerGradient.endPoint = CGPoint(x: 0, y: 1)
        _headerView.layer.addSublayer(_headerGradient)


        // Add UILabels
        let _titleLabel = UILabel(text: "Statistics", font: UIFont.systemFont(ofSize: 32, weight: .bold))
        let _subTitleLabel = UILabel(text: "Control your progress", font: UIFont.systemFont(ofSize: 14, weight: .regular))
        let _stack = UIStackView(arrangedSubviews: [_titleLabel, _subTitleLabel])
        _stack.axis = .vertical
        _stack.spacing = 4
        _headerView.addSubview(_stack)
        _stack.anchors(top: nil, leading: _headerView.leadingAnchor, trailing: _headerView.trailingAnchor, bottom: _headerView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: -12, right: 0))

        return _headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    fileprivate func setup() {
//        let _barChartNib = UINib(nibName: "BarChartContainerView", bundle: nil)
//        let _barChartView = _barChartNib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view.addSubview(headerView)
        self.view.addSubview(_barChartView)

        headerView.anchors(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, bottom: nil, size: CGSize(width: 0, height: 200))
        _barChartView.anchors(top: self.headerView.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 32, left: 16, bottom: -16, right: -16))
        _barChartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _headerGradient.frame = headerView.bounds
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

