//
//  SubscriptionSelectorViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

// SubscriptionSelectorViewController отображает общую информацию о подписке и ее возможные периоды. Предоставляет возможность
// аткивизировать подписку на определенный.

class SubscriptionSelectorViewController: UIViewController {

    public var onActivateCompleted:  ((SubscriptionSelectorViewController)->())?
    public var viewModel : SubscriptionSelectorViewModel?
    @IBOutlet weak var subscriptionGeneralInfosCollectionView: UICollectionView!
    @IBOutlet weak var subscriptionPeriodsCollectionView: UICollectionView!

    private var subscriptionGeneralInfoCollectionViewDataSource: SubscriptionGeneralInfoColletionViewDataSource?
    private var subscribtionPeriodsCollectionViewController: SubscriptionPeriodsCollectionViewController?

    @IBAction func onActivateTouch(_ sender: UIButton) {
        self.viewModel?.activate()
        self.onActivateCompleted?(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModel = self.viewModel {
            self.subscriptionGeneralInfoCollectionViewDataSource = SubscriptionGeneralInfoColletionViewDataSource(collectionView: self.subscriptionGeneralInfosCollectionView, viewModel: viewModel)
            self.subscribtionPeriodsCollectionViewController = SubscriptionPeriodsCollectionViewController(collectionView: self.subscriptionPeriodsCollectionView, viewModel: viewModel)
        }
    }
}
