//
//  MatchDataSourceTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Resolver
import Combine
@testable import CSTV

final class MatchDataSourceTests: XCTestCase {
    private var network: MockNetwork<[Match]>!
    private var cache: MockCache!

    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockNetwork<[Match]>()
            self.network = mock
            return mock
        }.implements(NetworkProtocol.self)
        
        Resolver.register {
            let mock = MockCache()
            self.cache = mock
            return mock
        }.implements(CacheProtocol.self)
    }
    
    func testGetMatchesFromRemoteSuccess() throws {
        let dataSource = RemoteMatchDataSource()
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect datasource to publish right values")
        
        let publisher = dataSource
            .getMatches()
            .sink { _ in
            } receiveValue: { matches in
                expectation.fulfill()
                XCTAssert(matches == expected)
            }
        
        network.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetMatchesFromRemoteError() throws {
        let dataSource = RemoteMatchDataSource()
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect datasource to publish error")
        
        let publisher = dataSource
            .getMatches()
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
    
    func testGetMatchesFromCacheNotEmpty() throws {
        let dataSource = CacheMatchDataSource()
        let cacheKey = CachedDateFormatter.shared.fetchMatchesFilterFormatter().string(from: Date())
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect datasource to publish right values")
        
        self.cache.insert(expected, forKey: cacheKey)
        
        let publisher = dataSource
            .getMatches()
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { matches in
                XCTAssert(matches == expected)
            }
        
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetMatchesFromCacheEmpty() throws {
        let dataSource = CacheMatchDataSource()
        let expected: [Match] = []
        let expectation = expectation(description: "expect datasource to publish right values")
        
        let publisher = dataSource
            .getMatches()
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { matches in
                XCTAssert(matches == expected)
            }
        
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
}
