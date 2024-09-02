//
//  League.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation

struct League: Codable, Identifiable {
    let id: String
    let name: String
    let imageURL: String?
}
extension League {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = "\(intId)"
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
}
