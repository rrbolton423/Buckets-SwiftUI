//
//  GamesViewModel.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

class GamesViewModel: ObservableObject {
    @Published var yesterdaysGames = [Game]()
    @Published var todaysGames = [Game]()
    @Published var tomorrowsGames = [Game]()

    @Published var errorMessage: String?
    @Published var isShowingError = false


    init() {
        self.getGames(day: Date.getDateString(date: Date.yesterday)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.yesterdaysGames = games
                }
//                print("Yesterday Call")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isShowingError = true
                self.yesterdaysGames = []
            }
        }

        self.getGames(day: Date.getDateString(date: Date.today)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.todaysGames = games
                }
//                print("Today Call")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isShowingError = true
                self.todaysGames = []
            }
        }

        self.getGames(day: Date.getDateString(date: Date.tomorrow)) { results in
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.tomorrowsGames = games
                }
//                print("Tomorrow Call")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isShowingError = true
                self.tomorrowsGames = []
            }
        }
    }

    func getGames(day: String, completed: @escaping (Result<[Game], Error>) -> Void) {
        let endpoint = "https://fly.sportsdata.io/v3/nba/scores/json/GamesByDate/\(day)?key=\(apiKey)"

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
                let games = try decoder.decode([Game].self, from: data)
                completed(.success(games))
            } catch {
                print(error.localizedDescription)
                completed(.failure(NBAError.decodingError))
            }
        }
        task.resume()
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var today: Date { return Date() }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    static func getDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        return dateFormatter.string(from: date)
    }
    static func getYearString() -> String {
        let year = Calendar.current.component(.year, from: Date())
        return "\(year)"
    }
}
