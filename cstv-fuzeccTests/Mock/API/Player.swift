//
//  Player.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 06/09/24.
//

import Foundation

let mockedPlayerPayload = Data("""
{
    "active": true,
    "current_team": {
        "acronym": "AUR.YB",
        "id": 133125,
        "image_url": "https://cdn.pandascore.co/images/team/image/133125/140px_aurora_young_blud_allmode.png",
        "location": "RU",
        "modified_at": "2024-09-01T20:19:41Z",
        "name": "Aurora Young Blood",
        "slug": "aurora-young-blood"
    },
    "current_videogame": {
        "id": 3,
        "name": "Counter-Strike",
        "slug": "cs-go"
    },
    "first_name": "Denis",
    "id": 48918,
    "image_url": null,
    "last_name": "Karpovich",
    "modified_at": "2024-09-01T20:19:41Z",
    "name": "m1QUSE",
    "nationality": "BY",
    "role": null,
    "slug": "m1quse"
}
""".utf8)
