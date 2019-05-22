//
//  MockURLProtocol.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var requestHandler: ( (URLRequest) throws -> (URLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard  let handler = MockURLProtocol.requestHandler else {
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {

    }
}
