//
//  FavoriteView.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @AppStorage("FavoriteTeam") private var favoriteTeam: Teams = .AtlantaHawks

    var body: some View {
        VStack {
            HeaderView(text: "Favorite Team")
                .padding()
            ScrollView {
                Text("Your favorite team is:")
                    .font(.title2)
                    .bold()
                VStack {
                    teamsDict[favoriteTeam.rawValue]!
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding()
                    Text(favoriteTeam.rawValue)
                        .font(.title)
                        .bold()
                }
                Picker("Team", selection: $favoriteTeam) {
                    ForEach(Teams.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static let favoriteTeam = Teams.LosAngelesLakers
    static var previews: some View {
        FavoriteView()
    }
}
