//
//  SubscriptionSelectorViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

// SubscriptionSelectorViewController displays general subscription information and its possible periods. Allows
// activate subscription for a specific period.

class SubscriptionSelectorViewController: UIViewController {

    public var onActivateCompleted:  ((SubscriptionSelectorViewController)->())?
    public var viewModel : SubscriptionSelectorViewModel?
    @IBOutlet weak var subscriptionGeneralInfosCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionPeriodsCollectionView: UICollectionView!

    private var subscriptionGeneralInfoCollectionViewDataSource: SubscriptionGeneralInfoColletionViewDataSource?
    private var subscribtionPeriodsCollectionViewController: SubscriptionPeriodsCollectionViewController?

    @IBAction func onActivateTouch(_ sender: UIButton) {
        self.viewModel?.activate(completion: {[weak self]() in
            OperationQueue.main.addOperation({
                guard let this = self else {
                    return
                }
                this.onActivateCompleted?(this)
            })
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSources()
    }

    fileprivate func setupDataSources() {
        if let viewModel = self.viewModel {
            self.subscriptionGeneralInfoCollectionViewDataSource = SubscriptionGeneralInfoColletionViewDataSource(collectionView: self.subscriptionGeneralInfosCollectionView, viewModel: viewModel)
            self.subscribtionPeriodsCollectionViewController = SubscriptionPeriodsCollectionViewController(collectionView: self.subscriptionPeriodsCollectionView, viewModel: viewModel)

            self.subscriptionGeneralInfoCollectionViewDataSource?.setup()
            self.subscribtionPeriodsCollectionViewController?.startLifecycle()
        }
    }

}
