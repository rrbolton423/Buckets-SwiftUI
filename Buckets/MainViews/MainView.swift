//
// Copyright © 2021 E*TRADE Financial. All rights reserved.
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
        .accentColor(.orange)
    }
}

#Preview {
    MainView()
}
