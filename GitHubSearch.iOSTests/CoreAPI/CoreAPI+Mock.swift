//
//  CoreAPI+Mock.swift
//  GitHubSearch.iOSTests
//
//  Created by Nikolay Dimitrov on 30.09.21.
//

import Foundation
import Combine
@testable import GitHubSearch_iOS

extension CoreAPI {
    
    private class MockRouter: Router {
        
        lazy var base: URL = Bundle(url: Bundle(for: type(of: self)).url(forResource: "CoreAPIMocks", withExtension: "bundle")!)!.bundleURL
        lazy var repositories: URL = base.appendingPathComponent("repositories/repositories")
    }
    
    private class MockNetworkClient: NetworkClient {
        
        func performRequestPublisher(_ request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
            
            let data = try! Data(contentsOf: request.url!)
            let response: URLResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return Just((data, response)).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    
    static var mock: Self {
        
        .init(router: MockRouter(), networkClient: MockNetworkClient())
    }
}
