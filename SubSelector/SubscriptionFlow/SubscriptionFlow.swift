//
//  SubscriptionFlow.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/16/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

// SubscriptionFlow отвечат за то, как будет происходить процесс покупки подписки.
class SubscriptionFlow {
    public var onActivate:  (()->())?
    private let rootController: UINavigationController
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    public func start() {
        let countrySelectorViewController = CountryListViewController()
        countrySelectorViewController.viewModel = CountryListViewModel()
        countrySelectorViewController.title = "Choose a Country"
        countrySelectorViewController.onCountrySelected = { [weak self] (controller: CountryListViewController, countryId: String) in self?.onCountrySelected(controller,countryId: countryId)
        }
        self.rootController.pushViewController(countrySelectorViewController, animated: true)
    }

    private func onCountrySelected(_ controller: CountryListViewController, countryId: String) {
        let subscriptionSelectorViewController = SubscriptionSelectorViewController()
        let viewModel = SubscriptionSelectorViewModel(countryId)
        subscriptionSelectorViewController.viewModel = viewModel
        subscriptionSelectorViewController.onActivateCompleted = { [weak self] (controller: SubscriptionSelectorViewController) in self?.onActivate(controller)}
        controller.navigationController?.pushViewController(subscriptionSelectorViewController, animated: true)
        subscriptionSelectorViewController.title = viewModel.phoneNumber
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        controller.navigationItem.backBarButtonItem = backItem
    }

    private func onActivate(_ controller: SubscriptionSelectorViewController) {
        controller.navigationController?.popViewController(animated: true)
        self.onActivate?()
    }
}
