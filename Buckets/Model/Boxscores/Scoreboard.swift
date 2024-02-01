//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/29/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Scoreboard: Codable {

    var games      : [Games]? = []

    enum CodingKeys: String, CodingKey {
        case games      = "games"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        games      = try values.decodeIfPresent([Games].self , forKey: .games      )
    }

    init() {

    }
}
