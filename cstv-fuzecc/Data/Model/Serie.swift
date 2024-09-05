//
//  Serie.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation

struct Serie: Codable, Identifiable {
    let id: String
    let name: String
}
extension Serie {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = "\(intId)"
        self.name = try container.decode(String.self, forKey: .name)
    }
}
