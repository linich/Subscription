//
//  CountryListViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation
import StoreKit

struct SubscriptionViewModel {
    struct Feature {
        let name: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }
    let localizedName: String
    let image: UIImage
    let features: [Feature]
}

class CountryListViewModel {
    public let data: DataController<SubscriptionViewModel>
    private let subscriptionList: [SubscriptionViewModel]
    private var filteredSubscriptionList: [SubscriptionViewModel]?
    init() {

        let smsColor = UIColor(red: 0x90/CGFloat(0xff), green: 0xCA/CGFloat(0xff), blue: 0xDD/CGFloat(0xff), alpha: 1)
        let callColor = UIColor(red: 0x69/CGFloat(0xff), green: 0xCF/CGFloat(0xA8), blue: 0xB5/CGFloat(0xff), alpha: 1)
        subscriptionList = [
            SubscriptionViewModel(
                localizedName: "United State",
                image: #imageLiteral(resourceName: "Add"),
                features: [SubscriptionViewModel.Feature(name:"CALLS", backgroundColor: callColor, textColor: UIColor.white ),
                           SubscriptionViewModel.Feature(name:"SMS",backgroundColor: smsColor, textColor: UIColor.white)]),
            SubscriptionViewModel(
                localizedName: "Belarus",
                image: #imageLiteral(resourceName: "Belarus"),
                features: [SubscriptionViewModel.Feature(name:"SMS",backgroundColor: smsColor, textColor: UIColor.white)]),
            SubscriptionViewModel(
                localizedName: "Finland",
                image: #imageLiteral(resourceName: "Finland"),
                features: [SubscriptionViewModel.Feature(name:"SMS",backgroundColor: smsColor, textColor: UIColor.white )]),
            SubscriptionViewModel(
                localizedName: "Belgium",
                image: #imageLiteral(resourceName: "Belgium"),
                features: [
                    SubscriptionViewModel.Feature(name:"CALLS",backgroundColor: callColor, textColor: UIColor.white ),
                    SubscriptionViewModel.Feature(name:"SMS",backgroundColor: smsColor, textColor: UIColor.white )])
            ].sorted(by: { (a, b) -> Bool in
                a.localizedName > a.localizedName
            })
        data = DataController(items: [subscriptionList])
    }

    var numberOfItems: Int {
        guard let filteredSubscriptionList = filteredSubscriptionList else {
            return subscriptionList.count
        }
        return filteredSubscriptionList.count
    }

    public func itemAt(_ index: Int) -> SubscriptionViewModel {
        if let filteredItems = filteredSubscriptionList {
            return filteredItems[index]
        }
        return subscriptionList[index]
    }

    public func countryId(atIndex: Int) -> String{
        return "CountryId"
    }

    public func filterItems(filter: String?) {
        guard let filter = filter else {
            filteredSubscriptionList = nil
            return
        }

        let filterBlock: (SubscriptionViewModel) -> Bool = { (viewModel) -> Bool in
            viewModel.localizedName.lowercased().contains(filter.lowercased())
        }
        
        let items =  filter.count > 0 ? [subscriptionList.filter(filterBlock)] : [subscriptionList]
        self.data.set(items: items)
    }
}

