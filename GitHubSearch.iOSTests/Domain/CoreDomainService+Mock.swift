//
//  CoreDomainService+Mock.swift
//  GitHubSearch.iOSTests
//
//  Created by Nikolay Dimitrov on 30.09.21.
//

import Foundation
@testable import GitHubSearch_iOS


extension CoreDomainService {
    
    struct MockState: State {
        
        var repositories: [Repository]?
    }
    
    static var mock: CoreDomainService {
        
        .init(state: MockState(), api: .mock)
    }
}
