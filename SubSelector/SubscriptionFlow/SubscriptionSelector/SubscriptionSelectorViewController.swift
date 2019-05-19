//
//  SubscriptionSelectorViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


class SubscriptionSelectorViewController: UIViewController, SubscriptionSelectorViewModelDelegate, UICollectionViewDelegate, DataControllerDelegate {

    public var onActivateCompleted:  ((SubscriptionSelectorViewController)->())?
    public var viewModel : SubscriptionSelectorViewModel?
    @IBOutlet weak var subscriptionGeneralInfosCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionPeriodsCollectionView: UICollectionView!

    private var subscriptionGeneralInfoCollectionViewDataSource: SubscriptionGeneralInfoColletionViewDataSource?
    private var subscriptionPeriodsCollectionViewDataSource: SubscriptionPeriodsCollectionViewDataSource?

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
            self.subscriptionPeriodsCollectionViewDataSource = SubscriptionPeriodsCollectionViewDataSource(subscriptions: viewModel.subscriptions)
            viewModel.subscriptions.delegate = self

            self.subscriptionGeneralInfoCollectionViewDataSource?.setup()
            self.subscriptionPeriodsCollectionViewDataSource?.attach(toCollectionView: self.subscriptionPeriodsCollectionView)
        }
    }

    // View Model Delegates
    func subscriptionSelectorViewModel(selectionChanged: SubscriptionSelectorViewModel) {
        self.subscriptionPeriodsCollectionView.reloadData()
    }

    // CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.viewModel?.selectSubscription(atIndex: indexPath.item)
    }

    // DataControllerDelegate
    func dataControllerDidChangeContent<T>(_ dataController: DataController<T>) {
        self.subscriptionPeriodsCollectionView.reloadData()
    }
}
