//
//  CountriesListProtocols.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/20/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

struct SubscriptionViewModel {
    struct Feature {
        let name: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }
    let localizedName: String
    let image: UIImage?
    let features: [Feature]
}

protocol ICountryListViewModel {
    var data: DataController<SubscriptionViewModel> { get }

    func loadData()
    func filterItems(filter: String?)
    func countryId(atIndexPath: IndexPath) -> String
}
