//
//  GamesView.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

struct GamesView: View {
    @StateObject var gamesViewModel = GamesViewModel()
    @State private var chosenDay: GameDays = .Today
    
    var body: some View {
        VStack {
            HeaderView(text: "Games")
                .padding()
            Picker("Days", selection: $chosenDay) {
                Text(GameDays.Yesterday.rawValue)
                    .tag(GameDays.Yesterday)
                Text(GameDays.Today.rawValue)
                    .tag(GameDays.Today)
                Text(GameDays.Tomorrow.rawValue)
                    .tag(GameDays.Tomorrow)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.horizontal, .bottom])
            
            ScrollView(showsIndicators: false) {
                if gamesViewModel.isLoading {
                    ProgressView()
                }
                else if gamesViewModel.isShowingError {
                    Text("Sorry, there was an error.")
                }
                else {
                    switch chosenDay {
                    case .Yesterday:
                        if (gamesViewModel.yesterdaysGames != nil) && (gamesViewModel.yesterdaysGames?.count == 0) {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.yesterdaysGames ?? [], id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    case .Today:
                        if (gamesViewModel.todaysGames != nil) && (gamesViewModel.todaysGames?.count == 0) {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.todaysGames ?? [], id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    case .Tomorrow:
                        if (gamesViewModel.tomorrowsGames) != nil && (gamesViewModel.tomorrowsGames?.count == 0) {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.tomorrowsGames ?? [], id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GameView: View {
    let game: Games
    
    @State private var isShowingDetails = false
    
    var body: some View {
        VStack {
            HStack {
                Image(game.awayTeam?.teamTricode ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                Spacer()
                Text("\(game.awayTeam?.score ?? 0) - \(game.homeTeam?.score ?? 0)")
                    .font(.title)
                    .bold()
                Spacer()
                Image(game.homeTeam?.teamTricode ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            
            Spacer()
            
            HStack {
                if game.gameStatus == 2 {
                    Text("Quarter: \(game.period ?? 0)")
                    Text("\(game.gameClock ?? "")"
                        .trimmingCharacters(in: .whitespacesAndNewlines))
                } else {
                    Text(game.gameStatusText ?? "")
                }
            }
            .font(.headline)
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            
            Spacer()
            
            if isShowingDetails {
                QuartersView(awayTeamPeriods: game.awayTeam?.periods ?? [], homeTeamPeriods: game.homeTeam?.periods ?? [], isShowingDetails: $isShowingDetails)
            }
            
        }
        .onTapGesture {
            isShowingDetails.toggle()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.gray))
    }
}

struct QuartersView: View {
    let awayTeamPeriods: [Periods]
    let homeTeamPeriods: [Periods]
    @Binding var isShowingDetails: Bool
    
    var body: some View {
        ForEach(Array(zip(awayTeamPeriods, homeTeamPeriods)), id: \.0) { quarter in
            HStack {
                Text("Quarter \(quarter.0.period ?? 0)")
                Spacer()
                Text("\(quarter.0.score ?? 0) - \(quarter.1.score ?? 0)")
            }
        }
        .font(.headline)
        .padding()
        .onTapGesture {
            isShowingDetails.toggle()
        }
    }
}

#Preview {
    GamesView()
}
