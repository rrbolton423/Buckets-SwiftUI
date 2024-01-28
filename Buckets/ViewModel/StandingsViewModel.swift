//
//  StandingsViewModel.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//
import Foundation

class StandingsViewModel: ObservableObject {
    @Published var standings: [Standings] = []
    @Published var errorMessage: String?
    @Published var isShowingError = false

    let standingsEndpoint   = "https://api.sportsdata.io/api/nba/odds/json/Standings/\(Date.getYearString())"

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

    func getStandings(completed: @escaping (Result<[Standings], Error>) -> Void) {
        guard let url = URL(string: standingsEndpoint) else {
            completed(.failure(NBAError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

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
                let standings = try decoder.decode([Standings].self, from: data)
                completed(.success(standings))
            } catch {
                print(error.localizedDescription)
                completed(.failure(NBAError.decodingError))
            }
        }
        task.resume()
    }
}
