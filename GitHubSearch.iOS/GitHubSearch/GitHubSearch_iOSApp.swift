//
//  GitHubSearch_iOSApp.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 27.09.21.
//

import SwiftUI

@main
struct GitHubSearch_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let applicationService = ApplicationService(environmentConfiguration: CurrentEnvironmentConfiguration())
    
    var body: some Scene {
        WindowGroup {
            
            RootView(applicationService: applicationService)
        }
    }
}
