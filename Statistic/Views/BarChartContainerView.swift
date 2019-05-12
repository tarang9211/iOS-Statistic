//
//  BarChartContainerView.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

class BarChartContainerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var _bars = [Bar]()

    lazy var titleLabel: UILabel = {
        let _title = UILabel(text: "Focus Time", textColor: .black, font: UIFont.systemFont(ofSize: 18, weight: .bold))
        return _title
    }()

    private let _cellIdentifier = "bar_cell"
    private var _collectionView: UICollectionView? = nil

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        setup()
        _collectionView?.reloadData()
    }

    fileprivate func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.createShadow(opacity: 0.4, offset: CGSize(width: 0, height: 8), radius: 8, color: .lightGray)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 1000.0
        _collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _collectionView?.register(BarCell.self, forCellWithReuseIdentifier: _cellIdentifier)
        _collectionView?.delegate = self
        _collectionView?.dataSource = self
        _collectionView?.backgroundColor = .white
        guard let _collectionView = _collectionView else {
            fatalError()
        }

        let stack = UIStackView(arrangedSubviews: [titleLabel, _collectionView])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        self.addSubview(stack)

        stack.anchors(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor
            , bottom: self.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))

    }

    fileprivate func setupData() {
        (0...32).forEach{ i in
            let color: UIColor
            if (i % 4 == 0) {
                color = #colorLiteral(red: 0.8, green: 0.6039215686, blue: 0.9568627451, alpha: 1)
            } else if (i % 5 == 0) {
                color = #colorLiteral(red: 0.9568627451, green: 0.6039215686, blue: 0.7607843137, alpha: 1)
            } else if (i % 3 == 0) {
                color = #colorLiteral(red: 0.7607843137, green: 0.9568627451, blue: 0.6039215686, alpha: 1)
            } else {
                color = #colorLiteral(red: 0.9568627451, green: 0.8, blue: 0.6039215686, alpha: 1)
            }
            _bars.append(Bar(index: i, percentageComplete: CGFloat.random(in: 0..<1), color: color))
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _bars.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _cellIdentifier, for: indexPath) as! BarCell
        cell.item = _bars[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 12, height: _collectionView!.frame.height)
    }


}

class BarCell: UICollectionViewCell {
    let width: CGFloat = 10

    var barFillHeightConstraint: NSLayoutConstraint!
    var dotViewHeightConstraint: NSLayoutConstraint!
    var dotViewWidthConstraint: NSLayoutConstraint!

    let barLabel = UILabel(text: "12", textColor: .lightGray, font: UIFont.systemFont(ofSize: 8, weight: .regular))

    var item: Bar! {
        didSet {
            setup()
        }
    }

    lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 3

        view.addSubview(barFillView)
        self.barFillView.anchors(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)

        self.barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: view.heightAnchor)
        self.barFillHeightConstraint.isActive = true
        return view
    }()

    lazy var barFillView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .blue
        return view
    }()

    lazy var dotViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return view
    }()

    lazy var dotView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        self.dotViewWidthConstraint = view.widthAnchor.constraint(equalToConstant: 0)
        self.dotViewHeightConstraint = view.heightAnchor.constraint(equalToConstant: 0)
        self.dotViewHeightConstraint.isActive = false
        self.dotViewWidthConstraint.isActive = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setup() {
        let stack = UIStackView(arrangedSubviews: [barView, dotViewContainer, barLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        self.addSubview(stack)
        stack.anchors(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor)

        //reset the height constraint for the barFillView to match the item percentage
        self.barFillHeightConstraint.isActive = false
        self.barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: self.barView.heightAnchor, multiplier: item.percentageComplete)
        self.barFillHeightConstraint.isActive = true
        self.barFillView.backgroundColor = item.color


        //reset the dotview constaints
        self.dotViewContainer.addSubview(dotView)

        if item.index % 6 == 0 {
            self.dotViewHeightConstraint.constant = 6
            self.dotViewWidthConstraint.constant = 6
            self.dotView.layer.cornerRadius = 3
        } else {
            self.dotViewHeightConstraint.constant = 4
            self.dotViewWidthConstraint.constant = 4
            self.dotView.layer.cornerRadius = 2
        }
        self.dotViewHeightConstraint.isActive = true
        self.dotViewWidthConstraint.isActive = true

        //center the dotview in the superview i.e. dotViewContainer
        self.dotView.centerXAnchor.constraint(equalTo: self.dotViewContainer.centerXAnchor).isActive = true
        self.dotView.centerYAnchor.constraint(equalTo: self.dotViewContainer.centerYAnchor).isActive = true

        barLabel.text = String(item.index)
        barLabel.textColor = item.index % 6 == 0 ? .lightGray : .clear
        barLabel.textAlignment = .center
        barLabel.numberOfLines = 0

    }
}


