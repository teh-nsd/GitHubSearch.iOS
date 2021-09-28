//
//  RepositoriesView.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import SwiftUI
import Combine

struct RepositoriesView: View {
    
    @EnvironmentObject var coreDomainService: CoreDomainService
    @State private var subscriptions = Set<AnyCancellable>()
    @State private var error: GitHubError?
    
    var body: some View {
        
        ZStack {
            Text("Hello, world!")
                .padding()
            
            VStack {EmptyView()}
                .alert(item: $error, content: { error in

                    .init(
                        title: Text("Something happened"),
                        message: Text(error.extendedDescription ?? error.localizedDescription),
                        dismissButton: .default(Text("Close"))
                    )
                })
        }
        .onAppear() {
            loadRepositories()
        }
    }
    
    private func loadRepositories(showLoading: Bool = true, showError: Bool = true) {
        
        coreDomainService.loadRepositories()
            .sink { completion in
                if case .failure(let err as GitHubError) = completion {
                    self.error = err
                }
            } receiveValue: { repositories in
                print(repositories)
            }
            .store(in: &subscriptions)
    }
}
