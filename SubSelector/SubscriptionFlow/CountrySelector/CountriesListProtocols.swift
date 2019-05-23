//
//  CountriesListProtocols.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/20/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

struct CountryInfo {
    struct Product {
        let name: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }
    let name: String
    let imageUri: String
    let availableProducts: [Product]
}

protocol ICountriesListViewModel {
    var data: DataController<CountryInfo> { get }

    func loadData()
    func filterItems(filter: String?)
    func countryId(atIndexPath: IndexPath) -> String
}
