//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/29/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Boxscores: Codable {

    var scoreboard : Scoreboard? = Scoreboard()
    
    enum CodingKeys: String, CodingKey {
        case scoreboard = "scoreboard"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scoreboard = try values.decodeIfPresent(Scoreboard.self , forKey: .scoreboard )
    }
    
    init() {
        
    }
}
