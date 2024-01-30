//
//  StandingsViewModel.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

class StandingsViewModel: ObservableObject {
    @Published var standings: [ResultSets] = []
    @Published var errorMessage: String?
    @Published var isShowingError = false
    
    let standingsEndpoint   = "https://proxy.boxscores.site/?apiUrl=stats.nba.com/stats/leaguestandingsv3&LeagueID=00&Season=2023"

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
                self.standings = []
            }
        }
    }
    
    func getStandings(completed: @escaping (Result<[ResultSets], Error>) -> Void) {
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
                    
                    var standings = [
                        "league": ["League Standings", ""],
                        "east": ["Eastern Conference Standings", ""],
                        "west": ["Western Conference Standings", ""],
                        "atlantic": ["Atlantic Division Standings", ""],
                        "central": ["Central Division Standings", ""],
                        "southeast": ["Southeast Division Standings", ""],
                        "northwest": ["Northwest Division Standings", ""],
                        "pacific": ["Pacific Division Standings", ""],
                        "southwest": ["Southwest Division Standings", ""]
                    ]
                    
                    var counter = 0
                    for teamData in rowSet {
                        guard let conference = teamData[headerIndexMap["Conference"]!] as? String,
                              let division = teamData[headerIndexMap["Division"]!] as? String else { continue }
                        
//                        if (["east", "west"].contains(setting) && setting != conference.lowercased()) ||
//                            (["atlantic", "central", "southeast", "northwest", "pacific", "southwest"].contains(setting) && setting != division.lowercased()) {
//                            continue
//                        }
                        
                        if conference == "East" {
                            print("Team Name = \(teamData[headerIndexMap["TeamName"]!]), Team City = \(teamData[headerIndexMap["TeamCity"]!])")
                        }
//                        print("TeamID = \(teamData[headerIndexMap["TeamID"]!])")
                        
                        counter += 1
//                        // Assuming `team`, `record`, `pct`, `gb`, and `streak` are obtained from `teamData` using `headerIndexMap`
//                        let tricode = teamNames[teamData[headerIndexMap["TeamID"]!] as! Int] ?? ""
                        let rank = counter
//                        print("rank = \(rank)")
////                        let emoji = teamEmojis[tricode] ?? ""
//                        let str2 = "\n`\(rank)` \(team) | \(record) \(pct) \(gb) \(streak)`"
                        // Append `str2` to the appropriate place in `standings`
                    }
                    // Update the interaction reply accordingly
                    
                } else {
                    // Handle the error, update the interaction reply accordingly
                }
            } catch {
                // Handle the error, update the interaction reply accordingly
            }
        }
        task.resume()
    }
}
 

