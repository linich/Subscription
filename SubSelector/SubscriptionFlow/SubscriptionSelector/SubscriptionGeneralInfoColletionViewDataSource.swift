//
//  SubscriptionGeneralInfoColletionViewDataSource.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


class SubscriptionGeneralInfoColletionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    private let viewModel: SubscriptionSelectorViewModel
    private weak var collectionView: UICollectionView?
    init (collectionView: UICollectionView, viewModel: SubscriptionSelectorViewModel) {
        self.viewModel = viewModel
        self.collectionView = collectionView
        super.init()
    }

    public func setup(){
        self.setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        guard let collectionView = self.collectionView else {
            return
        }

        collectionView.register(UINib(nibName: "SubscriptionGeneralInfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Details")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.size.width
            flowLayout.itemSize = CGSize(width:width, height: width)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.subscriptionGeneralInfoList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Details", for: indexPath) as? SubscriptionGeneralInfoCollectionViewCell  else {
            return UICollectionViewCell()
        }
        let data = self.viewModel.subscriptionGeneralInfoList[indexPath.item]
        cell.imageView.image = data.image
        cell.label.text = data.text
        return cell
    }
}
