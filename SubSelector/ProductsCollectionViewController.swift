//
//  ProductsCollectionViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


class ProductsCollectionViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    let viewModel: SubscriptionSelectorViewModel
    enum CellIds : CustomStringConvertible {
        case Product
        var description : String {
            switch self {
            case .Product: return "Product"
            }
        }
    }

    init (collectionView: UICollectionView, viewModel: SubscriptionSelectorViewModel) {
        self.viewModel = viewModel
        super.init()

        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: CellIds.Product))
        collectionView.dataSource = self
        collectionView.delegate = self

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.size.width / CGFloat(viewModel.subscripions.count)
            flowLayout.itemSize = CGSize(width:width, height: width)
            flowLayout.minimumInteritemSpacing = 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.subscripions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CellIds.Product), for: indexPath) as? ProductCollectionViewCell  else {
            return UICollectionViewCell()
        }
        let data = self.viewModel.subscripions[indexPath.item]
        cell.summaryLabel.attributedText = data.attributedText
        cell.contentView.backgroundColor = data.selected ? UIColor.blue : UIColor.white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectSubscription(atIndex: indexPath.item)
        collectionView.reloadData()
    }
}
