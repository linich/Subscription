//
//  CountriesRequestTests.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import XCTest
@testable import SubSelector

extension Country: Equatable {
    public static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id && lhs.name == lhs.name && lhs.products == rhs.products
    }
}

extension Country.Product: Equatable {
    public static func ==(lhs: Country.Product, rhs: Country.Product) -> Bool {
        return lhs.color == rhs.color && lhs.id == lhs.id && lhs.name == lhs.name
    }
}

class CountriesRequestTests: XCTestCase {
    let request = CountriesRequest()

    func testParsingEmptyResponse() throws {
        let jsonData = "[]".data(using: .utf8)!
        let response = try request.parseResponse(data: jsonData)
        XCTAssertEqual(response.count, 0)
    }


    func testParsingResponseWithOneCountry() throws {
        guard let jsonData = LoadData.string(fromResourceNamed: "CountriesWithOneItem")?.data(using: .utf8) else {
            XCTFail("Can't load jsonData")
            return
        }
        
        let response = try request.parseResponse(data: jsonData)
        let expectedProducts = [Country.Product(id: "id1", name: "productName", color: "ffaabb")]
        XCTAssertEqual(response, [Country(name: "Belarus", id: "belarus_id", products: expectedProducts)])
    }
}
