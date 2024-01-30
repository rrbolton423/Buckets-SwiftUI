//
//  Standings.swift
//  Buckets
//
//  Created by Romell Bolton on 1/29/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import Foundation

struct Periods: Codable {
    
    var period     : Int?    = nil
    var periodType : String? = nil
    var score      : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        
        case period     = "period"
        case periodType = "periodType"
        case score      = "score"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        period     = try values.decodeIfPresent(Int.self    , forKey: .period     )
        periodType = try values.decodeIfPresent(String.self , forKey: .periodType )
        score      = try values.decodeIfPresent(Int.self    , forKey: .score      )
        
    }
    
    init() {
        
    }
    
}

extension Periods: Hashable {
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: Periods, rhs: Periods) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
