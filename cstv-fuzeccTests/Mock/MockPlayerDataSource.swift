//
//  MockPlayerDataSource.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
import Combine
@testable import cstv_fuzecc

class MockRemotePlayerDataSource<T: Decodable>: PlayerDataSource {
    private let subject: PassthroughSubject<T, Error>
    
    init() {
        self.subject = PassthroughSubject<T, Error>()
    }
    
    func getPlayers(team: String) -> AnyPublisher<[Player], Error> {
        return self.subject.eraseToAnyPublisher() as! AnyPublisher<[Player], Error>
    }
    
    func send(value: T) {
        subject.send(value)
    }
    
    func send(error: URLError) {
        subject.send(completion: .failure(error))
    }
}
