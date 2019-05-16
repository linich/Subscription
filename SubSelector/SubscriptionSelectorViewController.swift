//
//  SubscriptionSelectorViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

class SubscriptionSelectorViewController: UIViewController {

    public var onActivateCompleted:  ((SubscriptionSelectorViewController)->())?
    public var viewModel : SubscriptionSelectorViewModel?
    @IBOutlet weak var selectedSubscriptionDetailsCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionCollectionView: UICollectionView!

    private var subscriptionsDetailsDataSource: SubscriptionGroupInfoDataSource?
    private var productsCollectionViewController: ProductsCollectionViewController?

    @IBAction func onActivateTouch(_ sender: UIButton) {
        self.viewModel?.activate()
        self.onActivateCompleted?(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModel = self.viewModel {
            self.subscriptionsDetailsDataSource = SubscriptionGroupInfoDataSource(collectionView: self.selectedSubscriptionDetailsCollectionView, viewModel: viewModel)
            self.productsCollectionViewController = ProductsCollectionViewController(collectionView: self.subscriptionCollectionView, viewModel: viewModel)
        }
    }
}
