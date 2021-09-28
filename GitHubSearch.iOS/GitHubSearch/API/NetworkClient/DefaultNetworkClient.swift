//
//  DefaultNetworkClient.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

class DefaultNetworkClient: NetworkClient {
    
    private let session: URLSession
    private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        return formatter
    }()
    
    init() {
        
        let configuration = URLSessionConfiguration.default
        
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
        let acceptLanguage = Locale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
            
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(languageCode);q=\(quality)"
        }.joined(separator: ", ")
        
        configuration.httpAdditionalHeaders = [
            "Accept-Language": acceptLanguage
        ]
        
        session = URLSession(configuration: configuration)
    }
    
    func performRequestPublisher(_ request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        print("@@ get")
        var request = request
        let timeZoneID = TimeZone.current.identifier
        let localTime = dateFormatter.string(from: Date())
        
        //add headers needed for the multi-timezone support
        request.addValue(timeZoneID, forHTTPHeaderField: "x-user-timezone")
        request.addValue(localTime, forHTTPHeaderField: "x-user-localtime")
        
        //disable network client cache
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        return self
            .session.dataTaskPublisher(for: request)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
