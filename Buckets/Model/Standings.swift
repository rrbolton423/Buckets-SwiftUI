//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Standings: Codable, Hashable {
    let Season: Int
    let TeamID: Int
    let City: String?           //City name             Ex: Philadelphia
    let Name: String?           //Full name of the team Ex: 76ers
    let Conference: String?
    let Division: String?

    let Wins: Int?
    let Losses: Int?
    let Percentage: Float?

    let ConferenceWins: Int?
    let ConferenceLosses: Int?
    let DivisionWins: Int?
    let DivisionLosses: Int?

    let HomeWins: Int?
    let HomeLosses: Int?
    let AwayWins: Int?
    let AwayLosses: Int?

    let LastTenWins: Int?
    let LastTenLosses: Int?
    let GamesBack: Float?

    let ConferenceRank: Int?
    let DivisionRank: Int?
}
