//
//  MockLeague.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import cstv_fuzecc

extension League {
    static func mock() -> League {
        let leagues = [
            League(id: "4734", name: "ESL Challenger League", imageURL: nil),
            League(id: "5078", name: "United21", 
                   imageURL: "https://cdn.pandascore.co/images/league/image/5078/800px-united21_allmode-png"),
            League(id: "4763", name: "Tipsport Cup",
                   imageURL: "https://cdn.pandascore.co/images/league/image/4763/800px-mistrovstvi_cr_2022_allmode-png"),
            League(id: "5232", name: "CCT Europe",
                   imageURL: "https://cdn.pandascore.co/images/league/image/5232/799px-cct_2024_europe_allmode-png"),
            League(id: "4243", name: "ESEA", imageURL: nil)
        ]
        return leagues.randomElement()!
    }
}
