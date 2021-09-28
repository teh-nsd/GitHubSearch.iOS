//
//  NetworkClient.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

///A type that performs requests
protocol NetworkClient {
    
    ///Returns a publisher that wraps a URL session data task for a given URLRequest
    func performRequestPublisher(_ request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}
