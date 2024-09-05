//
//  MatchesViewModelTests.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import XCTest
import Combine
@testable import cstv_fuzecc

final class MatchesViewModelTests: XCTestCase {
    override func setUpWithError() throws {
//        Resolver.register {
//            GetAllGuideShopsRepositoryMock(withSuccess: true)
//        }.implements(GetAllGuideShopsRepository.self)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadSuccess() throws {
        let fetchMatches = PassthroughSubject<[Match], Error>()
        
        
        
        let repository = MatchRepository()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

//class MockMatchesDataSource: MatchDataSource {
//    func getMatches() -> AnyPublisher<[cstv_fuzecc.Match], Error> {
//        
//    }
//}


//class MockDataFetcher: DataFetcher {
//    func fetchData() -> AnyPublisher<DataType, Error> {
//        let data = DataType(id: 1, userId: 1, title: "Mock Title", body: "Mock Body")
//        return Just(data)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
//}
