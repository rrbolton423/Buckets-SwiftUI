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

            let decoder = JSONDecoder()

            do {
                let standings = try decoder.decode(LeagueStandings.self, from: data)
                if let resultSets = standings.resultSets {
                    completed(.success(standings.resultSets ?? []))
                }
            } catch {
                print(error.localizedDescription)
                completed(.failure(NBAError.decodingError))
            }
        }
        task.resume()
    }
}
