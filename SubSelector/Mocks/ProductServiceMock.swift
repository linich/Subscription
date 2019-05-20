//
//  ProductServiceMock.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/20/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

fileprivate struct CountryInfo: ICountryInfo {
    let id: String
    let name: String
    let availableProducts: [IProductInfo]
}

fileprivate struct ProductInfo: IProductInfo {
    let id: String
    let name: String
    let color: UIColor 
}

class ProductServiceMock: IProductListService {
    public func loadCountries(completion: (([ICountryInfo]) -> Void)) {
        let smsColor = UIColor(red: 0x90/CGFloat(0xff), green: 0xCA/CGFloat(0xff), blue: 0xDD/CGFloat(0xff), alpha: 1)
        let callColor = UIColor(red: 0x69/CGFloat(0xff), green: 0xCF/CGFloat(0xA8), blue: 0xB5/CGFloat(0xff), alpha: 1)

        let callsProduct: ProductInfo = ProductInfo.init(id: "calls_product_id", name: "calls", color: callColor)
        let smsProduct: ProductInfo = ProductInfo.init(id: "sms_product_id", name: "calls", color: smsColor)
        let countries = [
            CountryInfo(id: "US", name: "United State", availableProducts: [callsProduct,smsProduct]),
            CountryInfo(id: "Belarus", name: "Belarus", availableProducts: [smsProduct]),
            CountryInfo(id: "Finland", name: "Finland", availableProducts: [callsProduct]),
            CountryInfo(id: "Belgium", name: "Belgium", availableProducts: [callsProduct, smsProduct])
        ]
        completion(countries)
    }
}
