//
//  ProductsService.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/24/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation
import StoreKit

protocol ProductsResponseProtocol {
    var products: [SKProduct] { get }
}

extension SKProductsResponse: ProductsResponseProtocol {

}

protocol ProductServiceProtocol {
    func loadProduct(ids: [String], completion:(ProductsResponseProtocol) -> ())
}

fileprivate struct ProductResponseMock: ProductsResponseProtocol {
    let products: [SKProduct]
}

struct ProductServiceMock:ProductServiceProtocol {
    func loadProduct(ids: [String], completion: (ProductsResponseProtocol) -> ()) {
        completion(ProductResponseMock(products: []))
    }
}
