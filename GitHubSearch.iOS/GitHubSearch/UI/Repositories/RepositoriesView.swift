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
    @ObservedObject private var query: AnyObservableObject<String> = .init("")
    @State private var repositories: [Repository] = []
    @State private var subscriptions = Set<AnyCancellable>()
    @State private var error: GitHubError?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Text("Searching for \(query.value.isEmpty ? "... ?" : query.value)")
                    .searchable(text: $query.value, prompt: "Search")
                
                List {
                    ForEach(repositories) { repository in
                        Link("\(repository.name)",
                             destination: repository.url)
                    }
                }
                .hidden(repositories.isEmpty)
                
                VStack { EmptyView() }
                .alert(item: $error,
                       content: { error in
                        .init(title: Text("Something happened"),
                              message: Text(error.extendedDescription ?? error.localizedDescription),
                              dismissButton: .default(Text("Close")))
                })
            }
            .navigationBarTitle("Repositories")
            .onAppear() {
                observeQueryChanges()
            }
        }
    }
    
    private func observeQueryChanges() {
        
        query.$value
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { $0 }
            .sink(receiveValue: searchRepository)
            .store(in: &subscriptions)
    }
    
    private func searchRepository(query: String) {
        
        guard !query.isEmpty else { return }
        
        loadRepositories(query: query)
    }
    
    private func loadRepositories(query: String) {
        
        coreDomainService.loadRepositories(query: query)
            .sink { completion in
                if case .failure(let err as GitHubError) = completion {
                    self.error = err
                }
            } receiveValue: { repositories in
                self.repositories = repositories
            }
            .store(in: &subscriptions)
    }
}
