//
//  CoreAPITests.swift
//  GitHubSearch.iOSTests
//
//  Created by Nikolay Dimitrov on 30.09.21.
//

import XCTest
import Combine
@testable import GitHubSearch_iOS

class CoreAPITests: XCTestCase {
    
    let api = CoreAPI.mock
    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        subscriptions = .init()
    }
    
    override func tearDownWithError() throws {
        
        subscriptions = .init()
    }
    
    func testGetRepositories() {
        
        let e = expectation(description: #function)
        e.expectedFulfillmentCount = 2
        
        api.getRepositories(query: "tetris")
            .sink(receiveCompletion: { completion in
                e.fulfill()
                
            }, receiveValue: { repositories in
                XCTAssertEqual(repositories.count, 3)
                XCTAssertEqual(repositories.first?.name, "react-tetris")
                XCTAssertEqual(repositories.first?.url, URL(string: "https://github.com/chvin/react-tetris"))
                
                e.fulfill()
            })
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 2)
    }
}
