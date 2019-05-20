//
//  SubscriptionPeriodsCollectionViewDataSource.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


let SubscriptionPeriodCellId = "SubscriptionPeriod"
class SubscriptionPeriodsCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    let subscriptions: DataController<SubscriptionPeriod>
    init (subscriptions: DataController<SubscriptionPeriod>) {
        self.subscriptions = subscriptions
        super.init()
    }


    func attach(toCollectionView collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "SubscriptionPeriodCollectionViewCell", bundle: Bundle.main), 
                forCellWithReuseIdentifier: String(describing: SubscriptionPeriodCellId))
        collectionView.dataSource = self
    }


    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscriptions.numberOfItems(inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscriptionPeriodCellId, for: indexPath) as? SubscriptionPeriodCollectionViewCell  else {
            return UICollectionViewCell()
        }
        let data = subscriptions.item(atIndexPath: indexPath)
        cell.summaryLabel.attributedText = data.attributedText
        cell.summaryLabel.textColor = data.selected ? Theme.selectedTextColor : Theme.appTextColor
        cell.contentView.backgroundColor = data.selected ? Theme.selectionColor : Theme.backgroundColor
        return cell
    }
}
