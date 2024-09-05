//
//  MatchRepositoryTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Resolver
import Combine
@testable import cstv_fuzecc

final class MatchRepositorySourceTests: XCTestCase {
    private var remoteDataSource: MockRemoteMatchDataSource<[Match]>!
    private var cachedDataSource: MockCacheMatchDataSource<[Match]>!

    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockRemoteMatchDataSource<[Match]>()
            self.remoteDataSource = mock
            return mock as RemoteMatchDataSource
        }.implements(MatchDataSource.self)
        Resolver.register {
            let mock = MockCacheMatchDataSource<[Match]>()
            self.cachedDataSource = mock
            return mock as CacheMatchDataSource
        }.implements(MatchDataSource.self)
    }
    
    func testGetMatchesAndSaveOnCache() throws {
        let repository = MatchRepository()
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect to fetch from remote and save on cache")
        
        let publisher = repository
            .getMatches()
            .sink { _ in
                
            } receiveValue: { matches in
                expectation.fulfill()
                XCTAssert(matches == expected)
                let stored = self.cachedDataSource.getStored()
                XCTAssertNotNil(stored)
                XCTAssert(stored! == expected)
            }
        
        cachedDataSource.send(value: [])
        remoteDataSource.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetMatchesFromRemote() throws {
        let repository = MatchRepository()
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect to fetch from remote")
        
        let publisher = repository
            .getMatches(forceRemote: true)
            .sink { _ in
                
            } receiveValue: { matches in
                expectation.fulfill()
                XCTAssert(matches == expected)
            }
        
        remoteDataSource.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testGetMatchesFromCache() throws {
        let repository = MatchRepository()
        let expected = [Match.mock(), Match.mock()]
        let cacheKey = CachedDateFormatter.shared.fetchMatchesFilterFormatter().string(from: Date())
        let expectation = expectation(description: "expect to fetch from cache")
        
        let publisher = repository
            .getMatches()
            .sink { _ in
                
            } receiveValue: { matches in
                expectation.fulfill()
                XCTAssert(matches == expected)
            }
        
        cachedDataSource.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
        
    }
}
