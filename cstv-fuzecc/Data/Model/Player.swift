//
//  Player.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation

struct Player: Codable, Identifiable {
    let id: String
    let active: Bool
    let name: String
    private let first: String?
    private let last: String?
    let nickname: String
    let imageURL: String?
}
extension Player {
    enum CodingKeys: String, CodingKey {
        case id
        case active
        case first = "first_name"
        case last = "last_name"
        case nickname = "name"
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = "\(intId)"
        self.active = try container.decode(Bool.self, forKey: .active)
        self.first = try container.decodeIfPresent(String.self, forKey: .first)
        self.last = try container.decodeIfPresent(String.self, forKey: .last)
        self.name = "\(first ?? "") \(last ?? "")"
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
}

