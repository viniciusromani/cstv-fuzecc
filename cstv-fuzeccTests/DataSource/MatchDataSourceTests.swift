//
//  MatchDataSourceTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Resolver
import Combine
@testable import cstv_fuzecc

final class MatchDataSourceTests: XCTestCase {
    private var network: MockNetwork<[Match]>!

    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockNetwork<[Match]>()
            self.network = mock
            return mock
        }.implements(NetworkProtocol.self)
    }
    
    func testGetMatchesSuccess() throws {
        let dataSource = RemoteMatchDataSource()
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect datasource to publish right values")
        
        let publisher = dataSource
            .getMatches()
            .sink { _ in
                
            } receiveValue: { matches in
                if matches == expected {
                    expectation.fulfill()
                }
            }
        
        network.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetMatchesError() throws {
        let dataSource = RemoteMatchDataSource()
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect datasource to publish error")
        
        let publisher = dataSource
            .getMatches()
            .sink { result in
                if case .failure(let error) = result {
                    if (error as? URLError)?.code == expected {
                        expectation.fulfill()
                    }
                }
            } receiveValue: { _ in }
        
        network.send(error: URLError(expected))
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
}
