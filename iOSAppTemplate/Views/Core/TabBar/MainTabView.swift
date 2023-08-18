//
//  MainTabView.swift
//  iOSAppTemplate
//
//  Created by apple on 09/08/23.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView{
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
            SerachView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("Upload Post")
                .tabItem {
                    Image(systemName: "plus.square")
                }
            Text("Notifications")
                .tabItem {
                    Image(systemName: "heart")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .tint(colorScheme == .light ? .black : .white)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
