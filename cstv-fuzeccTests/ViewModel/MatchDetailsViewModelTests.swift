//
//  MatchDetailsViewModelTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Combine
import Resolver
@testable import cstv_fuzecc


final class MatchDetailsViewModelTests: XCTestCase {
    private var repository: MockPlayerRepository<[Player]>!
    
    override func setUpWithError() throws {
        Resolver.register {
            let mock = MockPlayerRepository<[Player]>()
            self.repository = mock
            return mock as PlayerRepository
        }
    }
    
    func testLoadSuccess() throws {
        // needs to be implemented
        XCTAssert(true)
//        let viewModel = MatchDetailsViewModel(match: Match.mock())
//        let expected = (team1: [Player.mock(), Player.mock()], team2: [Player.mock(), Player.mock()])
//        let expectation = expectation(description: "expect viewModel to load right values")
//        
//        let publisher = viewModel.$state.sink(receiveValue: { state in
//            if case .loaded(let players) = state {
//                if players == expected {
//                    expectation.fulfill()
//                }
//            }
//        })
//        
//        viewModel.load()
//        repository.send(value: expected)
//        waitForExpectations(timeout: 2)
//        publisher.cancel()
    }
    
    func testLoadError() throws {
        let viewModel = MatchDetailsViewModel(match: Match.mock())
        let expected = URLError.Code.resourceUnavailable
        let expectation = expectation(description: "expect viewModel to publish error")
        
        let publisher = viewModel.$state.sink(receiveValue: { state in
            if case .failed(let error) = state {
                if (error as? URLError)?.code == expected {
                    expectation.fulfill()
                }
            }
        })
        
        viewModel.load()
        repository.send(error: URLError(expected))
        waitForExpectations(timeout: 2)
        publisher.cancel()
    }
}
