//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/30/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct LeagueStandings: Codable {

    var resultSets : [ResultSets]? = []

    enum CodingKeys: String, CodingKey {

        case resultSets = "resultSets"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        resultSets = try values.decodeIfPresent([ResultSets].self , forKey: .resultSets )

    }

    init() {

    }

}
