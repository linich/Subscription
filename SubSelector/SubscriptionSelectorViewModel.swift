//
//  SubscriptionSelectorViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

struct SubscriptionInfo {
    let attributedText: NSAttributedString
    let selected: Bool
}

struct SubscriptionDetails {
    let image: UIImage
    let text: String
}

class SubscriptionSelectorViewModel {
    public private(set) var subscripions: [SubscriptionInfo]
    public var selectedSubscriptionDetails: [SubscriptionDetails]
    public let phoneNumber: String
    public init(_ countryId: String) {
        // Использовать countryId для определения списка продуктов доступных для этой страны
        phoneNumber = "+375 29 223 43 12"
        subscripions = [
            SubscriptionInfo(attributedText: NSAttributedString(string: "3\nmonths\n$2.99"), selected: false),
            SubscriptionInfo(attributedText: NSAttributedString(string: "3-Day\ntrial\n$7.99.wk"), selected: true),
            SubscriptionInfo(attributedText: NSAttributedString(string: "12\nmonths\n$59.99"), selected: false)
        ]
        selectedSubscriptionDetails = [
        SubscriptionDetails(image: #imageLiteral(resourceName: "Belarus"), text: "Something  about Belarus"),
        SubscriptionDetails(image: #imageLiteral(resourceName: "Belgium"), text: "Something about Belgium")]
    }

    public func activate(){
        print("SubscriptionSelectorViewModel->activate")
    }

    public func selectSubscription(atIndex: Int){
        subscripions = subscripions.enumerated().map({ (index, info) -> SubscriptionInfo in
            return SubscriptionInfo(attributedText: info.attributedText, selected: index == atIndex)
        })
    }
}
