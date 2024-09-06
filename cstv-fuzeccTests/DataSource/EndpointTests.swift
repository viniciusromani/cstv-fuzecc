//
//  EndpointTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 06/09/24.
//

import XCTest
@testable import CSTV

final class EndpointTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testURL() throws {
        var endpoint: Endpoint = .matches
        var expected = URL(string: "https://api.pandascore.co/csgo/matches?")!
        XCTAssert(endpoint.url == expected)
        
        endpoint = .players
        expected = URL(string: "https://api.pandascore.co/csgo/players?")!
        XCTAssert(endpoint.url == expected)
    }
    
    func testHeaders() throws {
        let endpoint: Endpoint = .matches
        XCTAssert(endpoint.headers.keys.contains("Authorization"))
    }
}
