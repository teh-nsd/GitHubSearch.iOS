//
//  CoreAPI.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import Foundation
import Combine

struct CoreAPI {
    
    typealias Router = CoreAPIRouter
    
    struct DefaultRouter: Router {
        
        let base: URL
        var repositories: URL { base.appendingPathComponent("search/repositories") }
    }
    
    let router: Router
    let networkClient: NetworkClient
    
    func getRepositories() -> AnyPublisher<[Repository], Error> {
        
        /*
         Params:
         q    string    query
         The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as GitHub.com. To learn more about the format of the query, see Constructing a search query. See "Searching for repositories" for a detailed list of qualifiers.
         
         sort    string    query
         Sorts the results of your query by number of stars, forks, or help-wanted-issues or how recently the items were updated. Default: best match
         
         order    string    query
         Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort.
         Default: desc
         
         per_page    integer    query
         Results per page (max 100)
         Default: 30
         
         page    integer    query
         Page number of the results to fetch.
         Default: 1
         */
        
        var components = URLComponents(url: router.repositories, resolvingAgainstBaseURL: true)
        components?.percentEncodedQuery = "q=tetris" // TODO: Pass params
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        return networkClient.performRequestPublisher(request).decodeGitHubResponse()
    }
}

extension CoreAPI {
    
    init(base: URL, networkClient: NetworkClient) {
        
        self.init(router: DefaultRouter(base: base), networkClient: networkClient)
    }
}
