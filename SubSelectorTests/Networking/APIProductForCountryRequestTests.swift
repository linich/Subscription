//
//  APIProductForCountryRequestTests.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/24/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import XCTest
@testable import SubSelector

class APIProductForCountryRequestTests: XCTestCase {
    
    var loader: APIRequestLoader<ProductsForContryRequest>!
    override func setUp() {
        let request = ProductsForContryRequest()

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        let urlSession = URLSession(configuration: configuration)

        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }

    func testLoaderSuccess() {
        let jsonData = LoadData.string(fromResourceNamed: "Subscriptions")?.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            return ( URLResponse(), jsonData!)
        }

        let expectation = XCTestExpectation(description: "Subscriptions")
        var error: Error?
        var response: ProductsForContryResponse?
        loader.loadAPIRequest(requestData: ProductsForContryRequestData(countryId: "blr")) { (resp, err) in
            response = resp
            error = err

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 1)
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssertEqual(response!.productName, "Product name")
        XCTAssertEqual(response!.subscriptionProductIds, ["product_1", "product_2", "product_3"])
        XCTAssertEqual(response!.subscriptionProductIds, ["product_1", "product_2", "product_3"])
        XCTAssertEqual(response!.features.count, 3)
        XCTAssertEqual(response!.features[1].title, "To Do")

    }
}
