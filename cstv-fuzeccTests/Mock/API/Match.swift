//
//  Matches.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 06/09/24.
//

import Foundation


let mockedMatchPayload = Data("""
{
    "match_type": "best_of",
    "begin_at": "2024-09-06T01:41:06Z",
    "status": "finished",
    "videogame": {
        "id": 3,
        "name": "Counter-Strike",
        "slug": "cs-go"
    },
    "videogame_title": {
        "id": 13,
        "name": "Counter-Strike 2",
        "slug": "cs-2",
        "videogame_id": 3
    },
    "tournament": {
        "begin_at": "2024-09-04T01:00:00Z",
        "detailed_stats": false,
        "end_at": "2024-09-29T22:00:00Z",
        "has_bracket": true,
        "id": 14484,
        "league_id": 4243,
        "live_supported": false,
        "modified_at": "2024-09-04T05:06:47Z",
        "name": "Playoffs",
        "prizepool": null,
        "serie_id": 7751,
        "slug": "cs-go-esea-advanced-north-america-50-2024-playoffs",
        "tier": "d",
        "winner_id": null,
        "winner_type": "Team"
    },
    "rescheduled": true,
    "slug": "might-vs-kingsofthenorth-2024-09-06",
    "id": 1034639,
    "tournament_id": 14484,
    "name": "Upper Bracket Round 2 match 4: MIGHT vs KingsOfTheNorth",
    "winner_id": 133749,
    "live": {
        "opens_at": null,
        "supported": false,
        "url": null
    },
    "streams_list": [],
    "videogame_version": null,
    "results": [{
        "score": 2,
        "team_id": 133749
    }, {
        "score": 0,
        "team_id": 134289
    }],
    "league": {
        "id": 4243,
        "image_url": null,
        "modified_at": "2020-11-12T15:51:24Z",
        "name": "ESEA",
        "slug": "cs-go-esea",
        "url": "https://play.esea.net/"
    },
    "forfeit": false,
    "league_id": 4243,
    "detailed_stats": false,
    "serie": {
        "begin_at": "2024-07-17T01:00:00Z",
        "end_at": "2024-09-29T22:00:00Z",
        "full_name": "Advanced North America season 50 2024",
        "id": 7751,
        "league_id": 4243,
        "modified_at": "2024-07-16T08:35:12Z",
        "name": "Advanced North America",
        "season": "50",
        "slug": "cs-go-esea-advanced-north-america-50-2024",
        "winner_id": null,
        "winner_type": "Team",
        "year": 2024
    },
    "opponents": [{
        "opponent": {
            "acronym": "MIGHT",
            "id": 133749,
            "image_url": "https://cdn.pandascore.co/images/team/image/133749/161px_might_lightmode.png",
            "location": "US",
            "modified_at": "2024-09-04T04:44:31Z",
            "name": "MIGHT",
            "slug": "might"
        },
        "type": "Team"
    }, {
        "opponent": {
            "acronym": null,
            "id": 134289,
            "image_url": "https://cdn.pandascore.co/images/team/image/134289/ezgif_5_7b507fc5c7.png",
            "location": "US",
            "modified_at": "2024-09-02T20:01:27Z",
            "name": "KingsOfTheNorth",
            "slug": "kingsofthenorth"
        },
        "type": "Team"
    }],
    "winner_type": "Team",
    "number_of_games": 3,
    "serie_id": 7751,
    "original_scheduled_at": "2024-09-06T01:30:00Z",
    "games": [{
        "begin_at": "2024-09-06T01:41:06Z",
        "complete": true,
        "detailed_stats": false,
        "end_at": "2024-09-06T03:27:18Z",
        "finished": true,
        "forfeit": false,
        "id": 148489,
        "length": 6372,
        "match_id": 1034639,
        "position": 1,
        "status": "finished",
        "winner": {
            "id": 133749,
            "type": "Team"
        },
        "winner_type": "Team"
    }, {
        "begin_at": "2024-09-06T03:35:25Z",
        "complete": true,
        "detailed_stats": false,
        "end_at": "2024-09-06T04:08:16Z",
        "finished": true,
        "forfeit": false,
        "id": 148490,
        "length": 1970,
        "match_id": 1034639,
        "position": 2,
        "status": "finished",
        "winner": {
            "id": 133749,
            "type": "Team"
        },
        "winner_type": "Team"
    }],
    "modified_at": "2024-09-06T04:08:16Z",
    "scheduled_at": "2024-09-06T01:40:00Z",
    "game_advantage": null,
    "winner": {
        "acronym": "MIGHT",
        "id": 133749,
        "image_url": "https://cdn.pandascore.co/images/team/image/133749/161px_might_lightmode.png",
        "location": "US",
        "modified_at": "2024-09-04T04:44:31Z",
        "name": "MIGHT",
        "slug": "might"
    },
    "end_at": "2024-09-06T04:08:15Z",
    "draw": false
}
""".utf8)
