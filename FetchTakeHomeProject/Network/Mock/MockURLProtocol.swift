//
//  MockURLProtocol.swift
//  FetchTakeHomeProject
//
//  Created by DharmaMithra Tirunagari on 2/9/25.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var responseData: Data?
    static var responseStatusCode: Int = 200
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let client = client, let url = request.url {
            let response = HTTPURLResponse(
                url: url,
                statusCode: MockURLProtocol.responseStatusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )!
            
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = MockURLProtocol.responseData {
                client.urlProtocol(self, didLoad: data)
            }
            
            client.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {
        // No specific logic needed
    }
}
