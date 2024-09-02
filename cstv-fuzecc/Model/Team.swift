//
//  League.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation

struct Team: Codable, Identifiable {
    let id: String
    let name: String
    let acronym: String?
    let imageURL: String?
}
extension Team {
    enum RootCodingKey: String, CodingKey {
        case opponent
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case acronym
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKey.self)
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .opponent)
        
        let intId = try nested.decode(Int.self, forKey: .id)
        self.id = "\(intId)"
        self.name = try nested.decode(String.self, forKey: .name)
        self.acronym = try nested.decodeIfPresent(String.self, forKey: .acronym)
        self.imageURL = try nested.decodeIfPresent(String.self, forKey: .imageURL)
    }
}
