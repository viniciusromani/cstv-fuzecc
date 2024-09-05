//
//  PlayerRepositoryTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Resolver
import Combine
@testable import cstv_fuzecc

final class PlayerRepositorySourceTests: XCTestCase {
    private var dataSource: MockRemotePlayerDataSource<[Player]>!
    
    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockRemotePlayerDataSource<[Player]>()
            self.dataSource = mock
            return mock
        }.implements(PlayerDataSource.self)
    }
    
    func testGetPlayersSuccess() throws {
        let repository = PlayerRepository()
        let expected = [Player.mock(), Player.mock()]
        let expectation = expectation(description: "expect repository to load right values")
        
        let publisher = repository
            .getPlayers(team: "")
            .sink { _ in
                
            } receiveValue: { players in
                expectation.fulfill()
                XCTAssert(players == expected)
            }
        
        dataSource.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetPlayersError() throws {
        let repository = PlayerRepository()
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect repository to publish error")
        
        let publisher = dataSource
            .getPlayers(team: "")
            .sink { result in
                if case .failure(let error) = result {
                    expectation.fulfill()
                    XCTAssert((error as? URLError)?.code == expected)
                }
            } receiveValue: { _ in }
        
        dataSource.send(error: URLError(expected))
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
}
