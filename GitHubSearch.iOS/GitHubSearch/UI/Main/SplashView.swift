//
//  SplashView.swift
//  GitHubSearch.iOS
//
//  Created by Nikolay Dimitrov on 28.09.21.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        
        ZStack {
            
            Color.gray
            
            VStack {
                
                Spacer()
                    .frame(height: 240)
                
                HStack {
                    Image.init(systemName: "eye")
                    
                    Image.init(systemName: "folder.badge.person.crop")
                }
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
