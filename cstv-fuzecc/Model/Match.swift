//
//  Match.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation

struct Match: Codable, Identifiable {
    let id: String
    let status: String
    let scheduledAt: Date
    let opponents: [Team]
    let league: League
    let serie: Serie
}
extension Match {
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case scheduledAt = "scheduled_at"
        case opponents
        case league
        case serie
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = "\(intId)"
        self.status = try container.decode(String.self, forKey: .status)
        self.scheduledAt = try container.decode(Date.self, forKey: .scheduledAt)
        self.opponents = try container.decode([Team].self, forKey: .opponents)
        self.league = try container.decode(League.self, forKey: .league)
        self.serie = try container.decode(Serie.self, forKey: .serie)
    }
}

