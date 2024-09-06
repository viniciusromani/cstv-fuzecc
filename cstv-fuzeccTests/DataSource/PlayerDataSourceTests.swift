//
//  PlayerDataSourceTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Resolver
import Combine
@testable import CSTV

final class PlayerDataSourceTests: XCTestCase {
    private var network: MockNetwork<[Player]>!

    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockNetwork<[Player]>()
            self.network = mock
            return mock
        }.implements(NetworkProtocol.self)
    }
    
    func testGetPlayersFromRemoteSuccess() throws {
        let dataSource = RemotePlayerDataSource()
        let expected = [Player.mock(), Player.mock()]
        let expectation = expectation(description: "expect datasource to publish right values")
        
        let publisher = dataSource
            .getPlayers(team: "")
            .sink { _ in
                
            } receiveValue: { players in
                expectation.fulfill()
                XCTAssert(players == expected)
            }
        
        network.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetPlayersFromRemoteError() throws {
        let dataSource = RemotePlayerDataSource()
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect datasource to publish error")
        
        let publisher = dataSource
            .getPlayers(team: "")
            .sink { result in
                if case .failure(let error) = result {
                    expectation.fulfill()
                    XCTAssert((error as? URLError)?.code == expected)
                }
            } receiveValue: { _ in }
        
        network.send(error: URLError(expected))
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
}
