//
//  MockMatchRepository.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
import Combine
@testable import CSTV

class MockMatchRepository<T: Decodable>: MatchRepository {
    private let subject: PassthroughSubject<T, Error>
    
    override init() {
        self.subject = PassthroughSubject<T, Error>()
    }
    
    override func getMatches(forceRemote: Bool = false) -> AnyPublisher<[Match], Error> {
        return self.subject.eraseToAnyPublisher() as! AnyPublisher<[Match], Error>
    }
    
    func send(value: T) {
        subject.send(value)
    }
    
    func send(error: URLError) {
        subject.send(completion: .failure(error))
    }
}
