//
//  StandingsViewModel.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

class StandingsViewModel: ObservableObject {
    @Published var standings: [String : [Standing]] = [:]
    @Published var errorMessage: String?
    @Published var isShowingError = false

    init() {
        self.getStandings { results in
            switch results {
            case .success(let results):
                DispatchQueue.main.async {
                    self.standings = results
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isShowingError = true
                self.standings = [:]
            }
        }
    }

    func getStandings(completed: @escaping (Result<[String : [Standing]], Error>) -> Void) {
        let seasonStartYear = getSeasonStartYear()
        let standingsEndpoint = "https://proxy.boxscores.site/?apiUrl=stats.nba.com/stats/leaguestandingsv3&LeagueID=00&Season=\(seasonStartYear)"

        guard let url = URL(string: standingsEndpoint) else {
            completed(.failure(NBAError.badUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(NBAError.invalidResponse))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(NBAError.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(NBAError.invalidData))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let resultSets = json["resultSets"] as? [[String: Any]],
                   let headers = resultSets[0]["headers"] as? [String],
                   let rowSet = resultSets[0]["rowSet"] as? [[Any]] {

                    var headerIndexMap = [String: Int]()
                    for (index, header) in headers.enumerated() {
                        headerIndexMap[header] = index
                    }

                    var standings: [String : [Standing]] = [
                        "Eastern": [],
                        "Western": []
                    ]
                    var easternConferenceStandings = [Standing]()
                    var westernConferenceStandings = [Standing]()

                    for teamData in rowSet {
                        let City = teamData[headerIndexMap["TeamCity"]!] as? String
                        let Name = teamData[headerIndexMap["TeamName"]!] as? String
                        let Conference = teamData[headerIndexMap["Conference"]!] as? String
                        let Division = teamData[headerIndexMap["Division"]!] as? String

                        let Wins = teamData[headerIndexMap["WINS"]!] as? Int
                        let Losses = teamData[headerIndexMap["LOSSES"]!] as? Int
                        let Percentage = teamData[headerIndexMap["WinPCT"]!] as? Float

                        let ConferenceRecord = teamData[headerIndexMap["ConferenceRecord"]!] as? String
                        let DivisionRecord = teamData[headerIndexMap["DivisionRecord"]!] as? String

                        let HomeRecord = teamData[headerIndexMap["HOME"]!] as? String
                        let AwayRecord = teamData[headerIndexMap["ROAD"]!] as? String
                        let LastTenRecord = teamData[headerIndexMap["L10"]!] as? String

                        let ConferenceGamesBack = teamData[headerIndexMap["ConferenceGamesBack"]!] as? Float

                        let PlayoffRank = teamData[headerIndexMap["PlayoffRank"]!] as? Int
                        let DivisionRank = teamData[headerIndexMap["DivisionRank"]!] as? Int

                        let standing = Standing(City: City, Name: Name, Conference: Conference, Division: Division, Wins: Wins, Losses: Losses, Percentage: Percentage, ConferenceRecord: ConferenceRecord, DivisionRecord: DivisionRecord, HomeRecord: HomeRecord, AwayRecord: AwayRecord, LastTenRecord: LastTenRecord, ConferenceGamesBack: ConferenceGamesBack, PlayoffRank: PlayoffRank, DivisionRank: DivisionRank)

                        if standing.Conference == "East" {
                            easternConferenceStandings.append(standing)
                        }
                        else if standing.Conference == "West" {
                            westernConferenceStandings.append(standing)
                        }
                    }

                    standings.updateValue(easternConferenceStandings, forKey: "Eastern")
                    standings.updateValue(westernConferenceStandings, forKey: "Western")
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        DispatchQueue.main.async {
                            completed(.success(standings))
                        }
                    }
                } else {
                    completed(.failure(NBAError.decodingError))
                }
            } catch {
                print(error)
                completed(.failure(NBAError.decodingError))
            }
        }
        task.resume()
    }

    func getSeasonStartYear() -> String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let lastYear = String(currentYear - 1)
        return lastYear
    }
}
