//
//  StandingsView.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

struct StandingsView: View {
    @StateObject private var standingsViewModel = StandingsViewModel()
    @State private var chosenConference = Conferences.Western

    var body: some View {
        VStack {
            HeaderView(text: "Standings")
                .padding()
            ConferencePicker(chosenConference: $chosenConference)
            ScrollView(showsIndicators: false) {
                if standingsViewModel.isLoading {
                    ProgressView()
                }
                else if standingsViewModel.isShowingError {
                    Text("Sorry, there was an error.")
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                }
                else {
                    if standingsViewModel.isEmptyStandings {
                        Text("No standings available.")
                            .lineLimit(1)
                            .minimumScaleFactor(0.01)
                    }
                    else {
                        TopBar()
                        ForEach(standingsViewModel.standings[chosenConference.rawValue]?.sorted { $0.PlayoffRank! < $1.PlayoffRank! } ?? [], id: \.self) { team in
                            if ((team.Conference?.contains(chosenConference.rawValue)) != nil) {
                                TeamView(teamStandings: team, position: team.PlayoffRank!)
                                    .padding(.horizontal)
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static let vm = StandingsViewModel()
    static var previews: some View {
        StandingsView()
    }
}

struct TeamView: View {
    let teamStandings: Standing
    let position: Int
    @State private var showDetails = false

    var body: some View {
        HStack {
            Text("\(position)")
                .font(.headline)
                .frame(width: 16)

            Text(teamStandings.Name ?? "")
                .bold()

            Spacer()

            HStack {
                Spacer()
                Text("\(teamStandings.Wins ?? 0)")
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text("\(teamStandings.Losses ?? 0)")
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text(String(format: "%.2f",
                            teamStandings.Percentage ?? 0).replacingOccurrences(of: "0.", with: "."))
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text(String(format: "%.1f", teamStandings.ConferenceGamesBack ?? 0)
                    .replacingOccurrences(of: ".0", with: ""))
            }
            .frame(width: 40)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.01)
        .onTapGesture {
            showDetails.toggle()
        }

        if showDetails {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        ComponentView(symbol: SFSymbols.home, symbolText: "Home", record: "\(teamStandings.HomeRecord ?? "0 - 0")".replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)) // Remove whitespace from String
                        Spacer()
                        ComponentView(symbol: SFSymbols.away, symbolText: "Away", record: "\(teamStandings.AwayRecord ?? "0 - 0")".replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)) // Remove whitespace from String
                        Spacer()
                        ComponentView(symbol: SFSymbols.lastTen, symbolText: "Last 10", record: "\(teamStandings.LastTenRecord ?? "0 - 0")".replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)) // Remove whitespace from String
                    }
                    .padding(.bottom)

                    HStack(alignment: .center) {
                        VStack {
                            if teamStandings.Conference == "East" {
                                Text("Eastern Conference")
                                    .font(.headline)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                            }
                            else if teamStandings.Conference == "West" {
                                Text("Western Conference")
                                    .font(.headline)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                            }
                            ComponentView(symbol: SFSymbols.ranking, symbolText: "Rank: \(teamStandings.PlayoffRank ?? 0)", record: "\(teamStandings.ConferenceRecord ?? "0 - 0")")
                        }
                        Spacer()

                        VStack {
                            Text("\(teamStandings.Division ?? "") Division")
                                .font(.headline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)
                            ComponentView(symbol: SFSymbols.ranking, symbolText: "Rank: \(teamStandings.DivisionRank ?? 0)", record: "\(teamStandings.DivisionRecord ?? "0 - 0")")
                        }
                    }
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.primary))
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            .onTapGesture {
                showDetails.toggle()
            }
            Spacer()
        }
    }
}

struct TopBar: View {
    var body: some View {
        HStack {
            Text("")
                .font(.headline)
                .frame(width: 16)

            Text("")
                .bold()

            Spacer()

            HStack {
                Spacer()
                Text("W")
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text("L")
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text("%")
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text("GB")
            }
            .frame(width: 40)

        }
        .font(.headline)
        .lineLimit(1)
        .minimumScaleFactor(0.01)
        .padding(.horizontal)
    }
}

struct ConferencePicker: View {
    @Binding var chosenConference: Conferences
    var body: some View {
        Picker("Conference", selection: $chosenConference) {
            Text("Western").tag(Conferences.Western)
            Text("Eastern").tag(Conferences.Eastern)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding([.horizontal, .bottom])
    }
}

struct ComponentView: View {
    let symbol: String
    let symbolText: String
    let record: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                Text(symbolText)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(record)"
                    .replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) // Remove whitespace from String
                    .replacingOccurrences(of: "-", with: " - "))
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                Spacer()
            }
        }
    }
}

#Preview {
    StandingsView()
}
