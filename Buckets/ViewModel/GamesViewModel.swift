//
//  GamesViewModel.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

class GamesViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Games])
    }
    
    @Published private(set) var state = State.idle
    @Published var showAlert = false

    func load() {
        self.getGames(day: Date.getDateString(date: Date.yesterday)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.state = .loaded(games)
                    self.showAlert = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .failed(error)
                    self.showAlert = true
                }
            }
        }
        
        self.getGames(day: Date.getDateString(date: Date.today)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.state = .loaded(games)
                    self.showAlert = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .failed(error)
                    self.showAlert = true
                }
            }
        }
        
        self.getGames(day: Date.getDateString(date: Date.tomorrow)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.state = .loaded(games)
                    self.showAlert = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .failed(error)
                    self.showAlert = true
                }
            }
        }
    }
    
    func getGames(day: String, completed: @escaping (Result<[Games], Error>) -> Void) {
        state = .loading
        let endpoint = "https://proxy.boxscores.site/?apiUrl=stats.nba.com/stats/scoreboardv3&GameDate=\(day)&LeagueID=00"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(NBAError.badUrl))
            return
        }        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(NBAError.invalidData))
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
                let api = try decoder.decode(Boxscores.self, from: data)
                if let games = api.scoreboard?.games {
                    completed(.success(games))
                }
            } catch {
                print(error)
                completed(.failure(NBAError.decodingError))
            }
        }
        task.resume()
    }
}
