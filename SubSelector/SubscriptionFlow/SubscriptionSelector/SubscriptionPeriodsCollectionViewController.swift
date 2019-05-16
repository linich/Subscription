//
//  SubscriptionsPeriodsCollectionViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


// Decided to leave this class a postfik Controller since it behaves like a controller - is the data source for the UICollectionView
// and invokes model methods in response to user actions.
class SubscriptionPeriodsCollectionViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    let viewModel: SubscriptionSelectorViewModel
    weak var collectionView: UICollectionView?
    enum CellIds : CustomStringConvertible {
        case SubscriptionPeriod
        var description : String {
            switch self {
            case .SubscriptionPeriod: return "SubscriptionPeriod"
            }
        }
    }

    init (collectionView: UICollectionView, viewModel: SubscriptionSelectorViewModel) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        super.init()
    }

    public func startLifecycle() {
        setupCollectionView()
        viewModel.onSubscriptionChanged = {[weak self] () in
            self?.collectionView?.reloadData()
        }
    }

    fileprivate func setupCollectionView() {
        guard let collectionView = self.collectionView else {
            return
        }

        collectionView.register(UINib(nibName: "SubscriptionPeriodCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: CellIds.SubscriptionPeriod))
        collectionView.dataSource = self
        collectionView.delegate = self

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.size.width / CGFloat(viewModel.subscripionPeriodList.count)
            flowLayout.itemSize = CGSize(width:width, height: width)
            flowLayout.minimumInteritemSpacing = 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.subscripionPeriodList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CellIds.SubscriptionPeriod), for: indexPath) as? SubscriptionPeriodCollectionViewCell  else {
            return UICollectionViewCell()
        }
        let data = self.viewModel.subscripionPeriodList[indexPath.item]
        cell.summaryLabel.attributedText = data.attributedText
        cell.summaryLabel.textColor = data.selected ? Theme.selectedTextColor : Theme.appTextColor
        cell.contentView.backgroundColor = data.selected ? Theme.selectionColor : Theme.backgroundColor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectSubscription(atIndex: indexPath.item)
    }
}
