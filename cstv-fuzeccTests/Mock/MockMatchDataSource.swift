//
//  MockMatchDataSource.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
import Combine
@testable import CSTV

class MockRemoteMatchDataSource<T: Decodable>: RemoteMatchDataSource {
    private let subject: PassthroughSubject<T, Error>
    
    override init() {
        self.subject = PassthroughSubject<T, Error>()
    }
    
    override func getMatches() -> AnyPublisher<[Match], Error> {
        return self.subject.eraseToAnyPublisher() as! AnyPublisher
    }
    
    func send(value: T) {
        subject.send(value)
    }
    
    func send(error: URLError) {
        subject.send(completion: .failure(error))
    }
}

class MockCacheMatchDataSource<T: Decodable>: CacheMatchDataSource {
    private let subject: PassthroughSubject<T, Error>
    private var stored: T?
    
    override init() {
        subject = PassthroughSubject<T, Error>()
    }
    
    override func getMatches() -> AnyPublisher<[Match], Error> {
        return subject.eraseToAnyPublisher() as! AnyPublisher
    }
    
    override func save(matches: [Match]) {
        stored = matches as? T
    }
    
    func send(value: T) {
        subject.send(value)
    }
    
    func send(error: URLError) {
        subject.send(completion: .failure(error))
    }
    
    func getStored() -> T? {
        stored
    }
}
