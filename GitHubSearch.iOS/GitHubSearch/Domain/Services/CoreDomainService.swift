//
//  CoreDomainService.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

protocol CoreDomainServiceState {
    
    var repositories: [Repository]? { get set }
}

class CoreDomainService: ObservableObject {
    
    typealias State = CoreDomainServiceState
    
    struct PersistedState: State {
        
        var repositories: [Repository]?
    }
    
    @Published private(set) var state: State
    let api: CoreAPI
    private var subscriptions: [AnyHashable: AnyCancellable] = [:]
    
    init(state: State = PersistedState(), api: CoreAPI) {
        
        self.state = state
        self.api = api
    }
    
    func loadRepositories(query: String) -> AnyPublisher<[Repository], Error> {
        
        api.getRepositories(query: query)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] repositories in
                self?.state.repositories = repositories
            })
            .eraseToAnyPublisher()
    }
}
