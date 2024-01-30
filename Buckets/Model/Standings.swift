//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Standing: Codable, Hashable {
    let City: String?
    let Name: String?
    let Conference: String?
    let Division: String?
    
    let Wins: Int?
    let Losses: Int?
    let Percentage: Float?
    
    let ConferenceRecord: String?
    let DivisionRecord: String?
    
    let HomeRecord: String?
    let AwayRecord: String?
    
    let LastTenRecord: String?
    let DivisionGamesBack: Float?
    
    let PlayoffRank: Int?
    let DivisionRank: Int?
}
