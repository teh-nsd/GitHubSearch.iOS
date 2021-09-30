//
//  GitHubResponse.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

struct GitHubResponse<Result: Decodable>: Decodable {
    
    var items: [Result]?
    var message: String?
    var errors: [GitHubError]?
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    func decodeGitHubResponse<Result: Decodable>(using decoder: JSONDecoder = .init()) -> AnyPublisher<[Result], Error> {
        
        return self
            .map { $0.data }
            .decode(type: GitHubResponse<Result>.self, decoder: JSONDecoder.init())
            .tryMap { (response: GitHubResponse<Result>) in
                
                if var error = response.errors?.first {
                    error.message = response.message
                    throw error
                }
                
                guard let result = response.items else {
                    
                    throw ResponseHandlerError.invalidResult
                }
                
                return result
            }
            .eraseToAnyPublisher()
    }
}
