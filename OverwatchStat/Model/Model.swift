//
//  Model.swift
//  Valorant
//
//  Created by danyaq on 02.09.2021.
//

import Foundation


struct MainModel: Hashable, Codable{

    var icon, name, levelIcon, prestigeIcon, ratingIcon, endorsementIcon: String?
    var level, prestige, gamesWon, endorsement, rating: Int?
    var isPrivate: Bool
    var quickPlayStats: QuickPlayStatsModel?
    var competitiveStats: CompetitiveStatsModel?
    enum CodingKeys: String, CodingKey{
        case icon, name, levelIcon, prestigeIcon, rating, ratingIcon, level, prestige, gamesWon, quickPlayStats, competitiveStats, endorsementIcon, endorsement
        case isPrivate = "private"
        
    }
}


struct QuickPlayStatsModel: Hashable, Codable{

    var games: QuickGamesModel?
    var awards: QuickAwardsModel?
    enum CodingKeys: String, CodingKey{
        case games, awards
    }
}

struct QuickGamesModel: Hashable, Codable{
    
    var played, won: Int?
    enum CodingKeys: String, CodingKey{
        case played, won
    }
}

struct QuickAwardsModel: Hashable, Codable{
    
    var cards, medals, medalsBronze, medalsSilver, medalsGold: Int?
    enum CodingKeys: String, CodingKey{
        case cards, medals, medalsBronze, medalsSilver, medalsGold
    }
}

struct CompetitiveStatsModel: Hashable, Codable{
    
    var games: CompetitiveGameModel?
    var awards: CompetitiveAwardsModel?
    enum CodingKeys: String, CodingKey{
        case games, awards
    }
}

struct CompetitiveGameModel: Hashable, Codable{
    
    var played, won: Int?
    enum CodingKeys: String, CodingKey{
        case played, won
    }
}

struct CompetitiveAwardsModel: Hashable, Codable{
    
    var cards, medals, medalsBronze, medalsSilver, medalsGold: Int?
    enum CodingKeys: String, CodingKey{
        case cards, medals, medalsBronze, medalsSilver, medalsGold
    }
}
