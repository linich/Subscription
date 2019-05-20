//
//  SubscriptionFlow.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/16/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

// Subscription Flow is responsible for how the subscription purchase process will occur.

class SubscriptionFlow: NSObject, CountryListViewControllerDelegate {
    public var onActivateCompleted:  (()->())?
    private weak var rootController: UINavigationController?

    init(rootController: UINavigationController) {
        self.rootController = rootController
        rootController.navigationBar.hideBottomShadow()
    }

    public func start() {
        let countrySelectorViewController = CountriesListViewController()
        countrySelectorViewController.viewModel = CountriesListViewModel(productService: ProductServiceMock())
        countrySelectorViewController.title = "Select a Country"
        countrySelectorViewController.delegate = self
        self.rootController?.pushViewController(countrySelectorViewController, animated: true)
    }

    func countryListViewController(countryListViewController controller: CountriesListViewController, didSelectCountryWithId countryId: String) {
        let subscriptionSelectorViewController = SubscriptionSelectorViewController()
        let viewModel = SubscriptionSelectorViewModel(countryId)

        subscriptionSelectorViewController.viewModel = viewModel
        subscriptionSelectorViewController.onActivateCompleted = { [weak self] (controller: SubscriptionSelectorViewController) in
            self?.onActivate(controller)
        }

        subscriptionSelectorViewController.title = viewModel.phoneNumber

        let navigationController = UINavigationController(rootViewController:subscriptionSelectorViewController)
        navigationController.navigationBar.hideBottomShadow()

        controller.present(navigationController, animated: true, completion: nil)
    }

    private func onCountrySelected(_ controller: CountriesListViewController, countryId: String) {

    }

    private func onActivate(_ controller: SubscriptionSelectorViewController) {
        controller.dismiss(animated: true, completion: nil)
        self.onActivateCompleted?()
    }
}
