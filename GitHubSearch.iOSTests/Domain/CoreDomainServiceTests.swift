//
//  CoreDomainServiceTests.swift
//  GitHubSearch.iOSTests
//
//  Created by Nikolay Dimitrov on 30.09.21.
//

import XCTest
import Combine
@testable import GitHubSearch_iOS

class CoreDomainServiceTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        subscriptions = .init()
    }
    
    override func tearDownWithError() throws {
        
        subscriptions = .init()
    }
    
    
    func testLoadRepositories() throws {
        
        let e = expectation(description: #function)
        let service = CoreDomainService.mock
        
        service.loadRepositories(query: "tetris")
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        e.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                }
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
        
        waitForExpectations(timeout: 2)
        
        XCTAssertEqual(service.state.repositories?.first?.name, "react-tetris")
        XCTAssertEqual(service.state.repositories?.first?.url, URL(string: "https://github.com/chvin/react-tetris"))
    }
}
