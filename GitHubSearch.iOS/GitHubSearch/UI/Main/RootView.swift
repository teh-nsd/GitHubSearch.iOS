//
//  RootView.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var applicationService: ApplicationService
    
    var body: some View {
        
        ZStack {
            
            switch applicationService.state.content {
                    
                case .splash:
                    SplashView()
                        .transition(AnyTransition.opacity.animation(.linear))
                    
                case .main:
                    RepositoriesView()
                        .environmentObject(applicationService)
                        .environmentObject(applicationService.coreDomainService)
            }
        }
    }
}
