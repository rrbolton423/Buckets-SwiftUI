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
    @State private var chosenDay: GameDays = .Yesterday
    
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
                        if gamesViewModel.yesterdaysGames.isEmpty {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.yesterdaysGames, id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    case .Today:
                        if gamesViewModel.todaysGames.isEmpty {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.todaysGames, id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    case .Tomorrow:
                        if gamesViewModel.tomorrowsGames.isEmpty {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                            }
                        } else {
                            ForEach(gamesViewModel.tomorrowsGames, id: \.self) { game in
                                GameView(game: game)
                            }
                        }
                    }
                }
            }
            .padding()
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
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                Spacer()
                Image(game.homeTeam?.teamTricode ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            if game.gameStatus == 2 {
                HStack {
                    Text("Quarter: \(game.period ?? 0)")
                    Text("\(game.gameClock ?? "")"
                        .trimmingCharacters(in: .whitespacesAndNewlines))
                }
                .font(.headline)
            } else {
                Text(game.gameStatusText ?? "")
                    .font(.headline)
            }
            
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
                if quarter.0.period ?? 0 > 4 {
                    Text("\(quarter.0.period ?? 0)")
                } else {
                    Text("Quarter \(quarter.0.period ?? 0)")
                }
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
