//
//  MatchDetailsViewModelTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Combine
import Resolver
@testable import CSTV


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
        /**
         TODO: implement unit test to zipped api call
         */
        XCTAssert(true)
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
