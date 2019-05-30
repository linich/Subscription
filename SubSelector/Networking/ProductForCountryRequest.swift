//
//  ProductForCountryRequest.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/24/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation

public struct ProductsForContryResponse: Decodable {
    struct Feature: Decodable{
        let title: String
        let subTitle: String
        let imageUrl: String
    }

    let productName: String
    let features: [Feature]
    let subscriptionProductIds: [String]
}

public struct ProductsForContryRequestData {
    let countryId: String
}

public struct ProductsForContryRequest: APIRequest {
    typealias RequestDataType = ProductsForContryRequestData
    typealias ResponseDataType = ProductsForContryResponse

    func makeRequest(from data: ProductsForContryRequestData) throws -> URLRequest {
        let components = URLComponents(string: "country/\(data.countryId)/products")!
        return URLRequest(url: components.url(relativeTo: BaseUrlProvider.baseUrl)!)
    }

    func parseResponse(data: Data) throws -> ProductsForContryResponse{
        let decoder = JSONDecoder()
        return try decoder.decode(ProductsForContryResponse.self, from: data)
    }
}

