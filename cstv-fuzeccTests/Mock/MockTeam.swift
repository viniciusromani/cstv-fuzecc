//
//  MockTeam.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import cstv_fuzecc

extension Team {
    static func mock() -> Team {
        let teams = [
            Team(id: "130064", name: "Insilio", acronym: "INS",
                 imageURL: "https://cdn.pandascore.co/images/team/image/130064/148px_insilio_lightmode.png"),
            Team(id: "133726", name: "GUN5 Esports", acronym: "GUN5",
                 imageURL: "https://cdn.pandascore.co/images/team/image/133726/236px_gun5_esports_allmode.png"),
            Team(id: "135381", name: "Apogee Esports", acronym: nil,
                 imageURL: "https://cdn.pandascore.co/images/team/image/135381/157px_betclic_apogee_esports_darkmode.png"),
            Team(id: "135389", name: "NIP Svea", acronym: nil, imageURL: nil),
            Team(id: "134657", name: "Kario Mart", acronym: Optional("KM"), imageURL: nil)
        ]
        return teams.randomElement()!
    }
}
