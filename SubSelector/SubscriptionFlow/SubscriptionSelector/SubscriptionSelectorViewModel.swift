//
//  SubscriptionSelectorViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit
import StoreKit

struct SubscriptionPeriod {
    let attributedText: NSAttributedString
    let selected: Bool
}

struct SubscriptionGeneralInfo {
    let imageUrl: String
    let text: String
}

protocol SubscriptionSelectorViewModelDelegate: class {
    func subscriptionSelectorViewModel(selectionChanged: SubscriptionSelectorViewModel)
}

fileprivate extension ProductsForContryResponse.Feature {
    fileprivate func convert() -> SubscriptionGeneralInfo {
        return SubscriptionGeneralInfo(imageUrl: imageUrl, text: title)
    }
}

class SubscriptionSelectorViewModel: NSObject {
    private var subscriptionPeriodList: [SubscriptionPeriod]

    public let subscriptions: DataController<SubscriptionPeriod>
    public let subscriptionGeneralInfo: DataController<SubscriptionGeneralInfo>
    public let phoneNumber: String
    public weak  var delegate: SubscriptionSelectorViewModelDelegate?
    private let subscriptionLoader: APIRequestLoader<ProductsForContryRequest>

    public init(_ countryId: String, urlSession: URLSession = .shared) {
        phoneNumber = "+375 29 223 43 12"
        subscriptionPeriodList = [
        ]

        subscriptionGeneralInfo = DataController<SubscriptionGeneralInfo>(sections: [[]])
        subscriptions = DataController(sections: [subscriptionPeriodList])
        subscriptionLoader = APIRequestLoader(apiRequest: ProductsForContryRequest(), urlSession: urlSession)
        super.init()
        subscriptionLoader.loadAPIRequest(requestData: ProductsForContryRequestData(countryId: countryId)) {[weak self] (response, error) in
            guard let response = response else { return }
            let generalInfos = response.features.map(({ (feature) ->  SubscriptionGeneralInfo in
                return feature.convert()
            }))
            let request = SKProductsRequest(productIdentifiers: Set(response.subscriptionProductIds))
            request.start()
            request.delegate = self
            self?.subscriptionGeneralInfo.set(sections: [generalInfos])
        }
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

extension SubscriptionSelectorViewModel: SKProductsRequestDelegate{
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {

    }
}
