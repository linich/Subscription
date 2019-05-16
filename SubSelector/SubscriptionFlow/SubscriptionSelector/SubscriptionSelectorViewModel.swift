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

class SubscriptionSelectorViewModel {
    public private(set) var subscripionPeriodList: [SubscriptionPeriod]
    public var subscriptionGeneralInfoList: [SubscriptionGeneralInfo]
    public var onSubscriptionChanged: (()->())?
    public let phoneNumber: String
    public init(_ countryId: String) {
        // Use countryId to determine the list of subscriptions available for that country as well as a list of general information.
        // In a real application, a list of SKProduct will be formed here and on its basis will be formed
        // to list of SubscriptionPeriod
        phoneNumber = "+375 29 223 43 12"
        subscripionPeriodList = [
            SubscriptionPeriod(attributedText: NSAttributedString(string: "3\nmonths\n$2.99"), selected: false),
            SubscriptionPeriod(attributedText: NSAttributedString(string: "3-Day\ntrial\n$7.99.wk"), selected: true),
            SubscriptionPeriod(attributedText: NSAttributedString(string: "12\nmonths\n$59.99"), selected: false)
        ]
        subscriptionGeneralInfoList = [
        SubscriptionGeneralInfo(image: #imageLiteral(resourceName: "Belarus"), text: "Something about Belarus"),
        SubscriptionGeneralInfo(image: #imageLiteral(resourceName: "Belgium"), text: "Something about Belgium")]
    }

    public func activate(completion: (()->())?){
        completion?()
    }

    public func selectSubscription(atIndex: Int){
        defer {
            self.onSubscriptionChanged?()
        }

        subscripionPeriodList = subscripionPeriodList.enumerated().map({ (index, info) -> SubscriptionPeriod in
            return SubscriptionPeriod(attributedText: info.attributedText, selected: index == atIndex)
        })
    }
}
