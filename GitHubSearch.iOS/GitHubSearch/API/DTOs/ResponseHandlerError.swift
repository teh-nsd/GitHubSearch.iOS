//
//  ResponseHandlerError.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation

enum ResponseHandlerError: LocalizedError, CustomNSError {
    
    case invalidResult
    
    //MARK: - CustomNSError
    static var errorDomain: String { Bundle.main.bundleIdentifier! }
    
    //MARK: - LocalizedError
    var errorDescription: String? {
        
        switch self {
            case .invalidResult:
                return "Invalid result"
        }
    }
}

enum NetworkError: Error, Decodable {
    
    case badURL
    case noInternetConnection
}
