//
//  ApplicationService.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

class ApplicationService: ObservableObject {
    
    enum Content {
        
        case splash
        case main
    }
    
    struct State {
        
        fileprivate(set) var content: Content = .splash
    }
    
    @Published var state: State = .init()
    
    let environmentConfiguration: EnvironmentConfiguration
    let coreDomainService: CoreDomainService
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init(environmentConfiguration: EnvironmentConfiguration, coreDomainService: CoreDomainService) {
        
        self.environmentConfiguration = environmentConfiguration
        self.coreDomainService = coreDomainService
    }
    
    convenience init(environmentConfiguration: EnvironmentConfiguration) {
        
        let networkClient = DefaultNetworkClient()
        let api = CoreAPI(base: environmentConfiguration.coreAPI, networkClient: networkClient)
        let coreDomainService = CoreDomainService(api: api)
        self.init(environmentConfiguration: environmentConfiguration, coreDomainService: coreDomainService)
        
        setup()
    }
    
    func setup() {
        
        coordinateUserState()
    }
    
    func coordinateUserState() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now().advanced(by: .milliseconds(1500))) { [self] in
            state.content = .main
        }
    }
}
