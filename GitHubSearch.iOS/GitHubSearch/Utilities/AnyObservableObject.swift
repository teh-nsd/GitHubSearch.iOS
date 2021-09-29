//
//  AnyObservableObject.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 29.09.21.
//

import Foundation

class AnyObservableObject<T>: ObservableObject {
    
    @Published var value: T
    
    init(_ value: T) {
        
        self.value = value
    }
}
