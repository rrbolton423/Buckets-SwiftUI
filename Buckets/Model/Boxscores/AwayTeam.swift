//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/29/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct AwayTeam: Codable {
    
    var teamId            : Int?       = nil
    var teamName          : String?    = nil
    var teamCity          : String?    = nil
    var teamTricode       : String?    = nil
    var teamSlug          : String?    = nil
    var wins              : Int?       = nil
    var losses            : Int?       = nil
    var score             : Int?       = nil
    var seed              : Int?       = nil
    var inBonus           : String?    = nil
    var timeoutsRemaining : Int?       = nil
    var periods           : [Periods]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case teamId            = "teamId"
        case teamName          = "teamName"
        case teamCity          = "teamCity"
        case teamTricode       = "teamTricode"
        case teamSlug          = "teamSlug"
        case wins              = "wins"
        case losses            = "losses"
        case score             = "score"
        case seed              = "seed"
        case inBonus           = "inBonus"
        case timeoutsRemaining = "timeoutsRemaining"
        case periods           = "periods"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        teamId            = try values.decodeIfPresent(Int.self       , forKey: .teamId            )
        teamName          = try values.decodeIfPresent(String.self    , forKey: .teamName          )
        teamCity          = try values.decodeIfPresent(String.self    , forKey: .teamCity          )
        teamTricode       = try values.decodeIfPresent(String.self    , forKey: .teamTricode       )
        teamSlug          = try values.decodeIfPresent(String.self    , forKey: .teamSlug          )
        wins              = try values.decodeIfPresent(Int.self       , forKey: .wins              )
        losses            = try values.decodeIfPresent(Int.self       , forKey: .losses            )
        score             = try values.decodeIfPresent(Int.self       , forKey: .score             )
        seed              = try values.decodeIfPresent(Int.self       , forKey: .seed              )
        inBonus           = try values.decodeIfPresent(String.self    , forKey: .inBonus           )
        timeoutsRemaining = try values.decodeIfPresent(Int.self       , forKey: .timeoutsRemaining )
        periods           = try values.decodeIfPresent([Periods].self , forKey: .periods           )
        
    }
    
    init() {
        
    }
    
}
