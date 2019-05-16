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
    public let phoneNumber: String
    public init(_ countryId: String) {
        // Использовать countryId для определения списка подписок доступных для этой страны а также списока общей информации.
        // В реальном приложении сдесь будет формироваться список SKProduct и на его основании будет формироваться
        // список SubscriptionPeriod
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

    public func activate(){
        print("SubscriptionSelectorViewModel->activate")
    }

    public func selectSubscription(atIndex: Int){
        subscripionPeriodList = subscripionPeriodList.enumerated().map({ (index, info) -> SubscriptionPeriod in
            return SubscriptionPeriod(attributedText: info.attributedText, selected: index == atIndex)
        })
    }
}
