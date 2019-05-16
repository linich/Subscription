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
    }
    let localizedName: String
    let image: UIImage
    let features: [Feature]
}

class CountryListViewModel {
    private let subscriptionList: [SubscriptionViewModel]
    private var filteredSubscriptionList: [SubscriptionViewModel]?
    public var onItemsChanged:  (()->())?
    init() {
        subscriptionList = [
            SubscriptionViewModel(
                localizedName: "United State",
                image: #imageLiteral(resourceName: "Add"),
                features: [SubscriptionViewModel.Feature(name:"CALLS",backgroundColor: UIColor.black ),
                           SubscriptionViewModel.Feature(name:"SMS",backgroundColor: UIColor.green )]),
            SubscriptionViewModel(
                localizedName: "Belarus",
                image: #imageLiteral(resourceName: "Belarus"),
                features: [SubscriptionViewModel.Feature(name:"SMS",backgroundColor: UIColor.green )]),
            SubscriptionViewModel(
                localizedName: "Finland",
                image: #imageLiteral(resourceName: "Finland"),
                features: [SubscriptionViewModel.Feature(name:"SMS",backgroundColor: UIColor.green )]),
            SubscriptionViewModel(
                localizedName: "Belgium",
                image: #imageLiteral(resourceName: "Belgium"),
                features: [
                    SubscriptionViewModel.Feature(name:"CALLS",backgroundColor: UIColor.black ),
                    SubscriptionViewModel.Feature(name:"SMS",backgroundColor: UIColor.black )])
            ].sorted(by: { (a, b) -> Bool in
                a.localizedName > a.localizedName
            })
        filteredSubscriptionList = nil
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
        defer{
            if let onItemsChanged = onItemsChanged {
                onItemsChanged()
            }
        }

        guard let filter = filter else {
            filteredSubscriptionList = nil
            return
        }
        if filter.count > 0 {
            filteredSubscriptionList = subscriptionList.filter({ (viewModel) -> Bool in
                viewModel.localizedName.lowercased().contains(filter.lowercased())
            })
        } else {
            filteredSubscriptionList = nil
        }
    }
}
