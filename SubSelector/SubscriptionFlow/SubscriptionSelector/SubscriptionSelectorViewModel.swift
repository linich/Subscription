//
//  SubscriptionSelectorViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

struct SubscriptionPeriod {
    let attributedText: NSAttributedString
    let selected: Bool
}

struct SubscriptionGeneralInfo {
    let image: UIImage
    let text: String
}

protocol SubscriptionSelectorViewModelDelegate: class {
    func subscriptionSelectorViewModel(selectionChanged: SubscriptionSelectorViewModel)
}

class SubscriptionSelectorViewModel {
    private var subscriptionPeriodList: [SubscriptionPeriod]
    public let subscriptions: DataController<SubscriptionPeriod>
    public var subscriptionGeneralInfoList: [SubscriptionGeneralInfo]
    public let phoneNumber: String
    public weak  var delegate: SubscriptionSelectorViewModelDelegate?

    public init(_ countryId: String) {
        // Use countryId to determine the list of subscriptions available for that country as well as a list of general information.
        // In a real application, a list of SKProduct will be formed here and on its basis will be formed
        // to list of SubscriptionPeriod
        phoneNumber = "+375 29 223 43 12"
        subscriptionPeriodList = [
            SubscriptionPeriod(attributedText: NSAttributedString(string: "3\nmonths\n$2.99"), selected: false),
            SubscriptionPeriod(attributedText: NSAttributedString(string: "3-Day\ntrial\n$7.99.wk"), selected: true),
            SubscriptionPeriod(attributedText: NSAttributedString(string: "12\nmonths\n$59.99"), selected: false)
        ]
        subscriptionGeneralInfoList = [
        SubscriptionGeneralInfo(image: #imageLiteral(resourceName: "Belarus"), text: "Something about Belarus"),
        SubscriptionGeneralInfo(image: #imageLiteral(resourceName: "Belgium"), text: "Something about Belgium")]
        subscriptions = DataController(sections: [subscriptionPeriodList])
    }

    public func activate(completion: (()->())?){
        completion?()
    }

    public func selectSubscription(atIndex index: Int){
        subscriptions.set(sections: [subscriptionPeriodList.enumerated().map({ (itemIndex, info) -> SubscriptionPeriod in
            return SubscriptionPeriod(attributedText: info.attributedText, selected: itemIndex == index)
        })])
    }
}
