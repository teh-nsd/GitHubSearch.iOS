//
//  View+Hidden.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 29.09.21.
//

import SwiftUI

extension View {
    
    @ViewBuilder func hidden(_ isHidden: Bool) -> some View {
        
        if isHidden {
            hidden()
        }
        else {
            self
        }
    }
}
