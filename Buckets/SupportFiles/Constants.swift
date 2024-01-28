//
//  Constants.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

enum NBAError: String, Error {
    case badUrl             = "An error occured while retrieving the data, invalid url.\nPlease try again."
    case invalidResponse    = "Invalid response from the server.\nPlease try again."
    case invalidData        = "Invalid data received from the server.\nPlease try again."
    case decodingError      = "An error occured while decoding the data.\nPlease try again."
}


enum SFSymbols {
    static let games        = "calendar"
    static let standings    = "list.number"
    static let favorites    = "heart.fill"
    static let info         = "info.circle"
    static let home         = "house.fill"
    static let away         = "airplane"
    static let lastTen      = "gobackward.10"
    static let ranking      = "arrow.up.arrow.down.square"
}


enum Conferences: String, CaseIterable, Identifiable {
    case Western
    case Eastern
    var id: String { self.rawValue }
}


enum GameDays: String, CaseIterable, Identifiable {
    case Yesterday
    case Today
    case Tomorrow
    var id: String { self.rawValue }
}


enum Teams: String, CaseIterable, Identifiable {
    case AtlantaHawks             = "Atlanta Hawks"
    case BostonCeltics            = "Boston Celtics"
    case BrooklynNets             = "Brooklyn Nets"
    case CharlotteHornets         = "Charlotte Hornets"
    case ChicagoBulls             = "Chicago Bulls"
    case ClevelandCavaliers       = "Cleveland Cavaliers"
    case DallasMavericks          = "Dallas Mavericks"
    case DenverNuggets            = "Denver Nuggets"
    case DetroitPistons           = "Detroit Pistons"
    case GoldenStateWarriors      = "Golden State Warriors"
    case HoustonRockets           = "Houston Rockets"
    case IndianaPacers            = "Indiana Pacers"
    case LosAngelesClippers       = "Los Angeles Clippers"
    case LosAngelesLakers         = "Los Angeles Lakers"
    case MemphisGrizzlies         = "Memphis Grizzlies"
    case MiamiHeat                = "Miami Heat"
    case MilwaukeeBucks           = "Milwaukee Bucks"
    case MinnesotaTimberwolves    = "Minnesota Timberwolves"
    case NewOrleansPelicans       = "New Orleans Pelicans"
    case NewYorkKnicks            = "New York Knicks"
    case OklahomaCityThunder      = "Oklahoma City Thunder"
    case OrlandoMagic             = "Orlando Magic"
    case Philadelphia76ers        = "Philadelphia 76ers"
    case PhoenixSuns              = "Phoenix Suns"
    case PortlandTrailblazers     = "Portland Trailblazers"
    case SacramentoKings          = "Sacramento Kings"
    case SanAntonioSpurs          = "San Antonio Spurs"
    case TorontoRaptors           = "Toronto Raptors"
    case UtahJazz                 = "Utah Jazz"
    case WashingtonWizards        = "Washington Wizards"

    var id: String { self.rawValue }
}


let teamsArray = [
    "Atlanta Hawks",
    "Boston Celtics",
    "Brooklyn Nets",
    "Charlotte Hornets",
    "Chicago Bulls",
    "Cleveland Cavaliers",
    "Dallas Mavericks",
    "Denver Nuggets",
    "Detroit Pistons",
    "Golden State Warriors",
    "Houston Rockets",
    "Indiana Pacers",
    "Los Angeles Clippers",
    "Los Angeles Lakers",
    "Memphis Grizzlies",
    "Miami Heat",
    "Milwaukee Bucks",
    "Minnesota Timberwolves",
    "New Orleans Pelicans",
    "New York Knicks",
    "Oklahoma City Thunder",
    "Orlando Magic",
    "Philadelphia 76ers",
    "Phoenix Suns",
    "Portland Trailblazers",
    "Sacramento Kings",
    "San Antonio Spurs",
    "Toronto Raptors",
    "Utah Jazz",
    "Washington Wizards"
]

let teamsDict: [String : Image] = [
    "Atlanta Hawks" : Logos.AtlantaHawks,
    "Boston Celtics" : Logos.BostonCeltics,
    "Brooklyn Nets" : Logos.BrooklynNets,
    "Charlotte Hornets" : Logos.CharlotteHornets,
    "Chicago Bulls" : Logos.ChicagoBulls,
    "Cleveland Cavaliers" : Logos.ClevelandCavaliers,
    "Dallas Mavericks" : Logos.DallasMavericks,
    "Denver Nuggets" : Logos.DenverNuggets,
    "Detroit Pistons" : Logos.DetroitPistons,
    "Golden State Warriors" : Logos.GoldenStateWarriors,
    "Houston Rockets" : Logos.HoustonRockets,
    "Indiana Pacers" : Logos.IndianaPacers,
    "Los Angeles Clippers" : Logos.LosAngelesClippers,
    "Los Angeles Lakers" : Logos.LosAngelesLakers,
    "Memphis Grizzlies" : Logos.MemphisGrizzlies,
    "Miami Heat" : Logos.MiamiHeat,
    "Milwaukee Bucks" : Logos.MilwaukeeBucks,
    "Minnesota Timberwolves" : Logos.MinnesotaTimberwolves,
    "New Orleans Pelicans" : Logos.NewOrleansPelicans,
    "New York Knicks" : Logos.NewYorkKnicks,
    "Oklahoma City Thunder" : Logos.OklahomaCityThunder,
    "Orlando Magic" : Logos.OrlandoMagic,
    "Philadelphia 76ers" : Logos.Philadelphia76ers,
    "Phoenix Suns" : Logos.PhoenixSuns,
    "Portland Trailblazers" : Logos.PortlandTrailblazers,
    "Sacramento Kings" : Logos.SacramentoKings,
    "San Antonio Spurs" : Logos.SanAntonioSpurs,
    "Toronto Raptors" : Logos.TorontoRaptors,
    "Utah Jazz" : Logos.UtahJazz,
    "Washington Wizards" : Logos.WashingtonWizards
]


enum Logos {
    static let AtlantaHawks             = Image("ATL")
    static let BostonCeltics            = Image("BOS")
    static let BrooklynNets             = Image("BKN")
    static let CharlotteHornets         = Image("CHA")
    static let ChicagoBulls             = Image("CHI")
    static let ClevelandCavaliers       = Image("CLE")
    static let DallasMavericks          = Image("DAL")
    static let DenverNuggets            = Image("DEN")
    static let DetroitPistons           = Image("DET")
    static let GoldenStateWarriors      = Image("GSW")
    static let HoustonRockets           = Image("HOU")
    static let IndianaPacers            = Image("IND")
    static let LosAngelesClippers       = Image("LAC")
    static let LosAngelesLakers         = Image("LAL")
    static let MemphisGrizzlies         = Image("MEM")
    static let MiamiHeat                = Image("MIA")
    static let MilwaukeeBucks           = Image("MIL")
    static let MinnesotaTimberwolves    = Image("MIN")
    static let NewOrleansPelicans       = Image("NOP")
    static let NewYorkKnicks            = Image("NYK")
    static let OklahomaCityThunder      = Image("OKC")
    static let OrlandoMagic             = Image("ORL")
    static let Philadelphia76ers        = Image("PHI")
    static let PhoenixSuns              = Image("PHO")
    static let PortlandTrailblazers     = Image("POR")
    static let SacramentoKings          = Image("SAC")
    static let SanAntonioSpurs          = Image("SAS")
    static let TorontoRaptors           = Image("TOR")
    static let UtahJazz                 = Image("UTA")
    static let WashingtonWizards        = Image("WAS")
}


let team: [Int: Image] = [
    1: Logos.WashingtonWizards,
    2: Logos.CharlotteHornets,
    3: Logos.AtlantaHawks,
    4: Logos.MiamiHeat,
    5: Logos.OrlandoMagic,
    6: Logos.NewYorkKnicks,
    7: Logos.Philadelphia76ers,
    8: Logos.BrooklynNets,
    9: Logos.BostonCeltics,
    10: Logos.TorontoRaptors,
    11: Logos.ChicagoBulls,
    12: Logos.ClevelandCavaliers,
    13: Logos.IndianaPacers,
    14: Logos.DetroitPistons,
    15: Logos.MilwaukeeBucks,
    16: Logos.MinnesotaTimberwolves,
    17: Logos.UtahJazz,
    18: Logos.OklahomaCityThunder,
    19: Logos.PortlandTrailblazers,
    20: Logos.DenverNuggets,
    21: Logos.MemphisGrizzlies,
    22: Logos.HoustonRockets,
    23: Logos.NewOrleansPelicans,
    24: Logos.SanAntonioSpurs,
    25: Logos.DallasMavericks,
    26: Logos.GoldenStateWarriors,
    27: Logos.LosAngelesLakers,
    28: Logos.LosAngelesClippers,
    29: Logos.PhoenixSuns,
    30: Logos.SacramentoKings
]


let apiKey = ""
