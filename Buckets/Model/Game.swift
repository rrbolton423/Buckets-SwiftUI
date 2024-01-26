//
// Copyright © 2021 E*TRADE Financial. All rights reserved.
//

import Foundation

struct Game: Codable, Hashable {
    let Status: String?             //NIL, Scheduled, InProgress, Final, F/OT, Suspended, Postponed, Delayed, Canceled
    let Day: String
    let DateTime: String
    let AwayTeam: String
    let HomeTeam: String
    let AwayTeamID: Int
    let HomeTeamID: Int
    let AwayTeamScore: Int?
    let HomeTeamScore: Int?
    let Quarter: String?            //NIL, 1, 2, 3, 4, Half, OT
    let TimeRemainingMinutes: Int?
    let TimeRemainingSeconds: Int?

    let GlobalGameID: Int           //ID for this game, unique accross all sports/leagues

    let IsClosed: Bool
    let Quarters: [Quarter]

    struct Quarter: Codable, Hashable {
        let Number: Int             //Order of the quarters, OT = 5,6,7....
        let Name: String            //Quarter number in string: 1, 2, 3, 4, OT, OT2, OT3...
        let AwayScore: Int?
        let HomeScore: Int?
    }
}
