//
//  EnvironmentConfiguration.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation

protocol EnvironmentConfiguration {
    
    var coreAPI: URL { get }
}

struct ProductionEnvironmentConfiguration: EnvironmentConfiguration {
    
    let coreAPI = URL(string: "https://api.github.com/")!
}

typealias CurrentEnvironmentConfiguration = ProductionEnvironmentConfiguration
