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
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                }
                else {
                    switch chosenDay {
                    case .Yesterday:
                        if (gamesViewModel.yesterdaysGames != nil) && (gamesViewModel.yesterdaysGames?.count == 0) {
                            HStack(alignment: .center) {
                                Text(noGamesString)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
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
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
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
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
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

            HStack {
                if game.gameStatus == 2 {
                    Text("Quarter: \(game.period ?? 0)")
                    Text("\(game.gameClock ?? "")"
                        .trimmingCharacters(in: .whitespacesAndNewlines))
                } else {
                    // Remove trailing whitespace from "Final" gameStatusText from API response.
                    // API response:       "gameStatusText":"Final               "
                    // After API response: "gameStatusText":"Final"
                    Text(game.gameStatusText?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) ?? "")
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
                if let period = quarter.0.period {
                    switch period {
                    case 5...: // Handle Overtime Text
                        Text("OT\(period - 4)")
                    default:
                        Text("Quarter \(period)")
                    }
                }
                Spacer()
                Text("\(quarter.0.score ?? 0) - \(quarter.1.score ?? 0)")
            }
            .lineLimit(1)
            .minimumScaleFactor(0.01)
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
