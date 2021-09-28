//
//  Repositories.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation

struct Repositories: Codable {
    
    let id: Int
    let name: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case url = "html_url"
    }
}
