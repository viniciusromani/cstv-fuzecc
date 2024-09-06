//
//  PlayerTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 06/09/24.
//

import XCTest
@testable import CSTV

final class PlayerTests: XCTestCase {
    func testDecoding() throws {
        let formatter = CachedDateFormatter.shared.iso8601Formatter()
        let expected = Player(
            id: "48918",
            active: true,
            name: "Denis Karpovich",
            first: "Denis",
            last: "Karpovich",
            nickname: "m1QUSE",
            imageURL: nil
        )
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Player.self, from: mockedPlayerPayload)
        XCTAssertEqual(decoded, expected)
    }
}
