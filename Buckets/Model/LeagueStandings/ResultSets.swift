//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/30/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct ResultSets: Codable {

    var name    : String?     = nil
    var headers : [String]?   = []
    var rowSet  : [[String]]? = []

    enum CodingKeys: String, CodingKey {

        case name    = "name"
        case headers = "headers"
        case rowSet  = "rowSet"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name    = try values.decodeIfPresent(String.self     , forKey: .name    )
        headers = try values.decodeIfPresent([String].self   , forKey: .headers )
        rowSet  = try values.decodeIfPresent([[String]].self , forKey: .rowSet  )

    }

    init() {

    }

}
