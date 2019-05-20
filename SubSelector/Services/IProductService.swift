//
//  IConuntryListService.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/20/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

protocol IProductInfo {
    var id: String { get }
    var name: String { get }
    var color: UIColor { get }
}

protocol ICountryInfo {
    var id: String { get }
    var name: String { get }
    var availableProducts: [IProductInfo] { get }
}

protocol IProductService {
    func loadCountries(completion: (([ICountryInfo]) -> Void))
}
