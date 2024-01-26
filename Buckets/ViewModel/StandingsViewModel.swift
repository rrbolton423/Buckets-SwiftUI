//
// Copyright © 2021 E*TRADE Financial. All rights reserved.
//

import Foundation

class StandingsViewModel: ObservableObject {
    @Published var standings: [Standings] = []
    @Published var errorMessage: String?
    @Published var isShowingError = false

    let standingsEndpoint   = "https://fly.sportsdata.io/v3/nba/scores/json/Standings/\(Date.getYearString())?key=\(apiKey)"

    init() {
        self.getStandings { results in
            switch results {
            case .success(let results):
                DispatchQueue.main.async {
                    self.standings = results
                }
//                print("Standings Call")
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
