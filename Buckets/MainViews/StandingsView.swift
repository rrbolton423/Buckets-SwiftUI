//
// Copyright © 2021 E*TRADE Financial. All rights reserved.
//

import SwiftUI

import SwiftUI


struct StandingsView: View {
    @StateObject private var StandingsVM = StandingsViewModel()
    @State private var chosenConference = Conferences.Western

    var body: some View {
        VStack {
            HeaderView(text: "Standings")
                .padding()
            ConferencePicker(chosenConference: $chosenConference)
            TopBar()
            ScrollView(showsIndicators: false) {
                ForEach(StandingsVM.standings.sorted { $0.ConferenceRank! < $1.ConferenceRank! }, id: \.self) { team in
                    if team.Conference == chosenConference.rawValue {
                        TeamView(teamStandings: team, position: team.ConferenceRank!)
                            .padding(.horizontal)
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
    let teamStandings: Standings
    let position: Int
    @State private var showDetails = false

    var body: some View {
        HStack {
            Text("\(position)")
                .font(.headline)
                .frame(width: 16)

            team[teamStandings.TeamID]!
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36)

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
                Text(String(format: "%.2f", teamStandings.Percentage ?? 0).replacingOccurrences(of: "0.", with: "."))
            }
            .frame(width: 40)

            HStack {
                Spacer()
                Text(String(format: "%.1f", teamStandings.GamesBack ?? 0).replacingOccurrences(of: ".0", with: ""))
            }
            .frame(width: 40)

        }
        .onTapGesture {
            showDetails.toggle()
        }

        if showDetails {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        ComponentView(symbol: SFSymbols.home, symbolText: "Home", leftDigit: "\(teamStandings.HomeWins ?? 0)", rightDigit: "\(teamStandings.HomeLosses ?? 0)")
                        Spacer()
                        ComponentView(symbol: SFSymbols.away, symbolText: "Away", leftDigit: "\(teamStandings.AwayWins ?? 0)", rightDigit: "\(teamStandings.AwayLosses ?? 0)")
                        Spacer()
                        ComponentView(symbol: SFSymbols.lastTen, symbolText: "Last 10", leftDigit: "\(teamStandings.LastTenWins ?? 0)", rightDigit: "\(teamStandings.LastTenLosses ?? 0)")
                    }
                    .padding(.bottom)

                    HStack(alignment: .center) {
                        VStack {
                            Text("\(teamStandings.Conference ?? "") Conference")
                                .font(.headline)
                            ComponentView(symbol: SFSymbols.ranking, symbolText: "Rank: \(teamStandings.ConferenceRank ?? 0)", leftDigit: "\(teamStandings.ConferenceWins ?? 0)", rightDigit: "\(teamStandings.ConferenceLosses ?? 0)")
                        }
                        Spacer()

                        VStack {
                            Text("\(teamStandings.Division ?? "") Division")
                                .font(.headline)
                            ComponentView(symbol: SFSymbols.ranking, symbolText: "Rank: \(teamStandings.DivisionRank ?? 0)", leftDigit: "\(teamStandings.DivisionWins ?? 0)", rightDigit: "\(teamStandings.DivisionLosses ?? 0)")
                        }
                    }
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.primary))
            .onTapGesture {
                showDetails.toggle()
            }
            Spacer()
        }
    }
}


struct TopBar: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Text("W").frame(width: 40)
            Text("L").frame(width: 40)
            Text("%").frame(width: 40)
            Text("D").frame(width: 40)
        }
        .font(.headline)
        .padding(.horizontal, 4)
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
    let leftDigit: String
    let rightDigit: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                Text(symbolText)
                    .font(.headline)
            }
            Text("\(leftDigit) - \(rightDigit)")
                .bold()
        }
    }
}

#Preview {
    StandingsView()
}
