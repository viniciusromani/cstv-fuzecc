//
//  MockPlayer.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import cstv_fuzecc

extension Player {
    static func mock() -> Player {
        let players = [
            Player(id: "41168", active: true, name: "Samet Köklü", first: "Samet", last: "Köklü",
                   nickname: "jottAAA", imageURL: nil),
            Player(id: "28291", active: true, name: "Yasin Koç", first: "Yasin", last: "Koç", nickname: "xfl0ud",
                   imageURL: "https://cdn.pandascore.co/images/player/image/28291/xfl0ud_9_ine.png"),
            Player(id: "27094", active: true, name: "Adrian  Pieper", first: "Adrian ", last: "Pieper", nickname: "imd",
                   imageURL: "https://cdn.pandascore.co/images/player/image/27094/image_removebg_preview.png"),
            Player(id: "23228", active: true, name: "Flatron Halimi", first: "Flatron", last: "Halimi",
                   nickname: "juanflatroo", imageURL: nil),
            Player(id: "31321", active: true, name: "Munkhbold  Azbayar", first: "Munkhbold ", last: "Azbayar",
                   nickname: "senzu", imageURL: nil),
            Player(id: "30001", active: true, name: "Munkhbold Sodbayar", first: "Munkhbold", last: "Sodbayar",
                   nickname: "Techno", imageURL: "https://cdn.pandascore.co/images/player/image/30001/600px_techno4_k_at_antwerp_major_2022_apac_rmr.png"),
            Player(id: "23229", active: true, name: "Dionis Budeci", first: "Dionis", last: "Budeci",
                   nickname: "sinnopsyy", imageURL: nil),
            Player(id: "24661", active: true, name: "Alexandr Zlobin", first: "Alexandr", last: "Zlobin",
                   nickname: "Psycho", imageURL: "https://cdn.pandascore.co/images/player/image/24661/p24175.png")
        ]
        return players.randomElement()!
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
