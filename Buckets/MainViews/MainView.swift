//
//  MainView.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            GamesView()
                .tabItem {
                    Label("Games", systemImage: SFSymbols.games)
                }
            StandingsView()
                .tabItem {
                    Label("Standings", systemImage: SFSymbols.standings)
                }
            FavoriteView()
                .tabItem {
                    Label("Favorite", systemImage: SFSymbols.favorites)
                }
        }
    }
}

#Preview {
    MainView()
}
