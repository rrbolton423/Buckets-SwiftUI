//
// Copyright © 2021 E*TRADE Financial. All rights reserved.
//

import SwiftUI

struct GamesView: View {
    @StateObject var gamesVM = GamesViewModel()
    @State private var chosenDay: GameDays = .Today

    var body: some View {
        VStack {
            HeaderView(text: "Games")
                .padding()
            Picker("Days", selection: $chosenDay){
                Text(GameDays.Yesterday.rawValue).tag(GameDays.Yesterday)
                Text(GameDays.Today.rawValue).tag(GameDays.Today)
                Text(GameDays.Tomorrow.rawValue).tag(GameDays.Tomorrow)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.horizontal, .bottom])

            ScrollView(showsIndicators: false) {
                switch chosenDay {
                case .Yesterday:
                    ForEach(gamesVM.yesterdaysGames, id: \.self) { game in
                        GameView(game: game)
                    }
                case .Today:
                    ForEach(gamesVM.todaysGames, id: \.self) { game in
                        GameView(game: game)
                    }
                case .Tomorrow:
                    ForEach(gamesVM.tomorrowsGames, id: \.self) { game in
                        GameView(game: game)
                    }
                }
            }
            .padding()
        }




    }
}


struct GameView: View {
    let game: Game

    @State private var isShowingDetails = false

    var body: some View {
        VStack {
            HStack {
                team[game.AwayTeamID]!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
                Spacer()
                Text("\(game.AwayTeamScore ?? 0) - \(game.HomeTeamScore ?? 0)")
                    .font(.title)
                    .bold()
                Spacer()
                team[game.HomeTeamID]!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
            }
            if game.Status == "InProgress" {
                HStack {
                    Text("Quarter: \(game.Quarter ?? "")")
                    Text("\(game.TimeRemainingMinutes ?? 0):\(game.TimeRemainingSeconds ?? 0)")
                }
                .font(.headline)
            } else {
                Text(game.Status ?? "")
                    .font(.headline)
            }

            if isShowingDetails {
                QuartersView(quarters: game.Quarters, isShowingDetails: $isShowingDetails)
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
    let quarters: [Game.Quarter]
    @Binding var isShowingDetails: Bool

    var body: some View {
        ForEach(quarters, id: \.self) { quarter in
            HStack {
                if quarter.Name.starts(with: "OT") {
                    Text(quarter.Name)
                } else {
                    Text("Quarter \(quarter.Name)")
                }
                Spacer()
                Text("\(quarter.AwayScore ?? 0) - \(quarter.HomeScore ?? 0)")
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
