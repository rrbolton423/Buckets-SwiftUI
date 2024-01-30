//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/29/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Games: Codable {
    
    var gameId            : String?       = nil
    var gameCode          : String?       = nil
    var gameStatus        : Int?          = nil
    var gameStatusText    : String?       = nil
    var period            : Int?          = nil
    var gameClock         : String?       = nil
    var gameTimeUTC       : String?       = nil
    var gameEt            : String?       = nil
    var regulationPeriods : Int?          = nil
    var seriesGameNumber  : String?       = nil
    var seriesText        : String?       = nil
    var ifNecessary       : Bool?         = nil
    var seriesConference  : String?       = nil
    var poRoundDesc       : String?       = nil
    var gameSubtype       : String?       = nil
    var homeTeam          : HomeTeam?     = HomeTeam()
    var awayTeam          : AwayTeam?     = AwayTeam()
    
    enum CodingKeys: String, CodingKey {
        
        case gameId            = "gameId"
        case gameCode          = "gameCode"
        case gameStatus        = "gameStatus"
        case gameStatusText    = "gameStatusText"
        case period            = "period"
        case gameClock         = "gameClock"
        case gameTimeUTC       = "gameTimeUTC"
        case gameEt            = "gameEt"
        case regulationPeriods = "regulationPeriods"
        case seriesGameNumber  = "seriesGameNumber"
        case seriesText        = "seriesText"
        case ifNecessary       = "ifNecessary"
        case seriesConference  = "seriesConference"
        case poRoundDesc       = "poRoundDesc"
        case gameSubtype       = "gameSubtype"
        case homeTeam          = "homeTeam"
        case awayTeam          = "awayTeam"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        gameId            = try values.decodeIfPresent(String.self       , forKey: .gameId            )
        gameCode          = try values.decodeIfPresent(String.self       , forKey: .gameCode          )
        gameStatus        = try values.decodeIfPresent(Int.self          , forKey: .gameStatus        )
        gameStatusText    = try values.decodeIfPresent(String.self       , forKey: .gameStatusText    )
        period            = try values.decodeIfPresent(Int.self          , forKey: .period            )
        gameClock         = try values.decodeIfPresent(String.self       , forKey: .gameClock         )
        gameTimeUTC       = try values.decodeIfPresent(String.self       , forKey: .gameTimeUTC       )
        gameEt            = try values.decodeIfPresent(String.self       , forKey: .gameEt            )
        regulationPeriods = try values.decodeIfPresent(Int.self          , forKey: .regulationPeriods )
        seriesGameNumber  = try values.decodeIfPresent(String.self       , forKey: .seriesGameNumber  )
        seriesText        = try values.decodeIfPresent(String.self       , forKey: .seriesText        )
        ifNecessary       = try values.decodeIfPresent(Bool.self         , forKey: .ifNecessary       )
        seriesConference  = try values.decodeIfPresent(String.self       , forKey: .seriesConference  )
        poRoundDesc       = try values.decodeIfPresent(String.self       , forKey: .poRoundDesc       )
        gameSubtype       = try values.decodeIfPresent(String.self       , forKey: .gameSubtype       )
        homeTeam          = try values.decodeIfPresent(HomeTeam.self     , forKey: .homeTeam          )
        awayTeam          = try values.decodeIfPresent(AwayTeam.self     , forKey: .awayTeam          )
        
    }
    
    init() {
        
    }
    
}

extension Games: Hashable {

    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: Games, rhs: Games) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
