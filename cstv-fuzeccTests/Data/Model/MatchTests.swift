//
//  MatchTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 06/09/24.
//

import XCTest
@testable import CSTV

final class MatchTests: XCTestCase {
    func testDecoding() throws {
        let formatter = CachedDateFormatter.shared.iso8601Formatter()
        let expected = Match(
            id: "1034639",
            status: "finished",
            scheduledAt: formatter.date(from: "2024-09-06T01:40:00Z")!,
            opponents: [
                Team(
                    id: "133749",
                    name: "MIGHT",
                    acronym: "MIGHT",
                    imageURL: "https://cdn.pandascore.co/images/team/image/133749/161px_might_lightmode.png"
                ),
                Team(
                    id: "134289",
                    name: "KingsOfTheNorth",
                    acronym: nil,
                    imageURL: "https://cdn.pandascore.co/images/team/image/134289/ezgif_5_7b507fc5c7.png"
                )
            ],
            league: League(
                id: "4243",
                name: "ESEA",
                imageURL: "https://play.esea.net/"
            ),
            serie: Serie(
                id: "7751",
                name: "Advanced North America"
            ))
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(CachedDateFormatter.shared.iso8601Formatter())
        let decoded = try decoder.decode(Match.self, from: mockedMatchPayload)
        XCTAssertEqual(decoded, expected)
    }
}
