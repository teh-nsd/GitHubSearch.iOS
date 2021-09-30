//
//  GitHubError.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 28.09.21.
//

import Foundation

struct GitHubError: Codable, LocalizedError, CustomNSError {
    
    var resource: String?
    var field: String?
    var code: String?
    
    // Custom fields
    var message: String?
    
    var extendedDescription: String? {
        guard let message = message else {
            return "Slabo manqk"
        }

        var localizedDescription = message
        
        if let code = code {
            localizedDescription = localizedDescription + "\n" + code
        }
        
        if let resource = resource {
            localizedDescription = localizedDescription + "\n" + resource
        }
        
        if let field = field {
            localizedDescription = localizedDescription + "\n" + field
        }
        
        return localizedDescription
    }
}

extension GitHubError: Identifiable {
    
    var id: String { UUID().uuidString }
}
