//
//  APILoaderTests.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import XCTest
@testable import SubSelector

class APICountriesLoaderTests: XCTestCase {
    var loader: APIRequestLoader<CountriesRequest>!
    override func setUp() {
        let request = CountriesRequest()

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        let urlSession = URLSession(configuration: configuration)

        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }

    func testLoaderSuccess() {
        guard let jsonData = LoadData.string(fromResourceNamed: "CountriesWithOneItem")?.data(using: .utf8) else {
            XCTFail("Can't load jsonData")
            return
        }

        MockURLProtocol.requestHandler = { request in
            return ( URLResponse(), jsonData)
        }

        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: CountryRequestData()) { (countries, error) in
            XCTAssertNil(error)
            guard let countries = countries else { XCTFail("Countries in nill"); return}
            let expectedProducts = [CountryResponse.Product(id: "id1", name: "productName", color: "ffaabb")]
            XCTAssertEqual(countries, [CountryResponse(name: "Belarus", id: "belarus_id", products: expectedProducts)])
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 1)
    }
}
