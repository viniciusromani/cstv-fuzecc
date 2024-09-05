//
//  MockNetwork.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
import Combine
@testable import cstv_fuzecc

class MockNetwork<T: Decodable>: NetworkProtocol {
    private let subject: PassthroughSubject<T, Error>
    private var url: URL!
    
    init() {
        self.subject = PassthroughSubject<T, Error>()
    }
    
    func get<A>(type: A.Type, url: URL, headers: Headers) -> AnyPublisher<A, Error> where A : Decodable {
        self.url = url
        return self.subject.eraseToAnyPublisher() as! AnyPublisher<A, Error>
    }
    
    func send(value: T) {
        subject.send(value)
    }
    
    func send(error: URLError) {
        subject.send(completion: .failure(error))
    }
}
