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
    private weak var subscriptionContainerViewController: UINavigationController?
    private let urlSession: URLSession

    init(rootController: UINavigationController, session: URLSession = .shared) {
        self.rootController = rootController
        self.urlSession = session
        rootController.navigationBar.hideBottomShadow()
    }

    public func start() {
        let countrySelectorViewController = CountriesListViewController()
        countrySelectorViewController.viewModel = CountriesListViewModel(urlSession: urlSession)
        countrySelectorViewController.title = "Select a Country"
        countrySelectorViewController.delegate = self
        self.rootController?.pushViewController(countrySelectorViewController, animated: true)
    }

    func countryListViewController(countryListViewController controller: CountriesListViewController, didSelectCountryWithId countryId: String) {
        let subscriptionSelectorViewController = SubscriptionSelectorViewController()
        let viewModel = SubscriptionSelectorViewModel(countryId, urlSession: urlSession)

        subscriptionSelectorViewController.viewModel = viewModel
        subscriptionSelectorViewController.onActivateCompleted = { [weak self] (controller: SubscriptionSelectorViewController) in
            self?.onActivate(controller)
        }

        subscriptionSelectorViewController.title = viewModel.phoneNumber

        let navigationController = UINavigationController(rootViewController:subscriptionSelectorViewController)
        navigationController.navigationBar.hideBottomShadow()
        subscriptionSelectorViewController.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeSubscriptionController))
        self.subscriptionContainerViewController = navigationController
        controller.present(navigationController, animated: true, completion: nil)
    }

    @objc public func closeSubscriptionController() {
        self.subscriptionContainerViewController?.dismiss(animated: true, completion: nil)
    }

    private func onActivate(_ controller: SubscriptionSelectorViewController) {
        controller.dismiss(animated: true, completion: nil)
        self.onActivateCompleted?()
    }
}
