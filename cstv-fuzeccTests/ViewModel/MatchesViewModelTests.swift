//
//  MatchesViewModelTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Combine
import Resolver
@testable import CSTV

final class MatchesViewModelTests: XCTestCase {
    private var repository: MockMatchRepository<[Match]>!
    
    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockMatchRepository<[Match]>()
            self.repository = mock
            return mock as MatchRepository
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadSuccess() throws {
        let viewModel = MatchesViewModel()
        let expected = [Match.mock(), Match.mock()]
        let expectation = expectation(description: "expect viewModel to load right values")
        
        let publisher = viewModel.$state.sink(receiveValue: { state in
            if case .loaded(let matches) = state {
                print("im insde load success")
                print("matches \(matches)")
                print("matches \(expected)")
                expectation.fulfill()
                XCTAssert(matches.allSatisfy(expected.contains))
            }
        })
        
        viewModel.load()
        repository.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testLoadRemovingNotTodayMatches() throws {
        let viewModel = MatchesViewModel()
        let yesterdayMatch = Match.mockYesterday()
        let expected = [Match.mock(), yesterdayMatch]
        let expectation = expectation(description: "expect viewModel to load right values")
        
        let publisher = viewModel.$state.sink(receiveValue: { state in
            if case .loaded(let matches) = state {
                expectation.fulfill()
                XCTAssert(!matches.contains(yesterdayMatch))
            }
        })
        
        viewModel.load()
        repository.send(value: expected)
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testLoadError() throws {
        let viewModel = MatchesViewModel()
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect viewModel to publish error")
        
        let publisher = viewModel.$state.sink(receiveValue: { state in
            if case .failed(let error) = state {
                expectation.fulfill()
                XCTAssert((error as? URLError)?.code == expected)
            }
        })
        
        viewModel.load()
        repository.send(error: URLError(expected))
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
    
    func testSort() throws {
        let viewModel = MatchesViewModel()
        let expected = Match.mockSorted()
        let result = viewModel.sort(matches: Match.shuffled())
        
        XCTAssert(result == expected)
    }
}
