//
//  CountriesRequest.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation

public struct CountryResponse: Decodable {
    struct Product: Decodable {
        let id: String
        let name: String
        let color: String
    }

    let name: String
    let id: String
    let products: [Product]
}

public struct CountryRequestData {
}

public struct CountriesRequest: APIRequest {
    typealias RequestDataType = CountryRequestData
    typealias ResponseDataType = [CountryResponse]

    func makeRequest(from data: CountryRequestData =  CountryRequestData()) throws -> URLRequest {
        let components = URLComponents(string: "countries")!
        return URLRequest.init(url: components.url(relativeTo: BaseUrlProvider.baseUrl)!)
    }

    func parseResponse(data: Data) throws -> [CountryResponse]{
        let decoder = JSONDecoder()
        return try decoder.decode([CountryResponse].self, from: data)
    }
}

