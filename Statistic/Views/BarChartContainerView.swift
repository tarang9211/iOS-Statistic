//
//  BarChartContainerView.swift
//  Statistic
//
//  Created by Tarang Hirani on 5/1/19.
//  Copyright © 2019 Tarang Hirani. All rights reserved.
//

import UIKit

class BarChartContainerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    var _bars = [Bar]()

    lazy var titleLabel: UILabel = {
        let _title = UILabel(text: "Focus Time", textColor: .black, font: UIFont.systemFont(ofSize: 18, weight: .bold))
        return _title
    }()

    private let _cellIdentifier = "bar_cell"
    private var _collectionView: UICollectionView? = nil

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        setup()
    }

    fileprivate func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.createShadow(opacity: 0.4, offset: CGSize(width: 0, height: 8), radius: 8, color: .lightGray)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
        (0...10).forEach{ i in
            _bars.append(Bar(index: i, percentageComplete: 10, color: .black))
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _cellIdentifier, for: indexPath) as! BarCell
        cell.item = _bars[indexPath.row]
        return cell
    }

}

class BarCell: UICollectionViewCell {

    var item: Bar! {
        didSet {
            setup()
        }
    }

    var barView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup() {
        print("called")
        self.addSubview(barView)
    }
}


