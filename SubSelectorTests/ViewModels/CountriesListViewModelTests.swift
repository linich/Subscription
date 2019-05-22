//
//  CountriesListViewModelTests.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import XCTest
@testable import SubSelector

class CountriesListViewModelTests: XCTestCase, DataControllerDelegate {
    var urlSession: URLSession!
    var data: Data!
    var expectation: XCTestExpectation!
    var viewModel: CountriesListViewModel!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        urlSession = URLSession(configuration: configuration)
        MockURLProtocol.requestHandler = { (request) in
            return (URLResponse(), self.data)
        }
        viewModel = CountriesListViewModel(urlSession: urlSession)
        viewModel.data.delegate = self
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
    }

    func testLoadCountries() {
        data = LoadData.string(fromResourceNamed: "CountriesWithOneItem")?.data(using: .utf8)!
        self.expectation = XCTestExpectation(description: "load data")
        viewModel.loadData()
        self.wait(for: [self.expectation], timeout: 1)
        XCTAssertEqual(viewModel.data.numberOfSections, 1)
        XCTAssertEqual(viewModel.data.numberOfItems(inSection: 0), 1)

        let countryInfo = viewModel.data.item(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(countryInfo.name, "Belarus")
        XCTAssertEqual(countryInfo.availableProducts.count, 1)
        XCTAssertEqual(countryInfo.availableProducts[0].name, "PRODUCTNAME")
        XCTAssertEqual(countryInfo.availableProducts[0].backgroundColor, UIColor(red: 0xff/CGFloat(255), green: 0xaa/CGFloat(255), blue: 0xbb/CGFloat(255), alpha: 1))
    }

    func dataControllerDidChangeContent<T>(_ dataController: DataController<T>) {
        self.expectation.fulfill()
    }
}
