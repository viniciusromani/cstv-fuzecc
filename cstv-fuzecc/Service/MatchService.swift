//
//  MatchService.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import Combine

protocol MatchServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getMatches() -> AnyPublisher<[Match], Error>
    func getMatch(id: String) -> AnyPublisher<Match, Error>
}

class MatchService: MatchServiceProtocol {
    let network: NetworkProtocol
    
    private lazy var formatter: ISO8601DateFormatter = {
        let _formatter = ISO8601DateFormatter()
        _formatter.timeZone = TimeZone.current
        _formatter.formatOptions = [.withFullDate]
        return _formatter
    }()
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getMatches() -> AnyPublisher<[Match], Error> {
        var endpoint: Endpoint = .matches
        endpoint.queryItems = [
            URLQueryItem(name: "filter[begin_at]", value: formatter.string(from: Date())),
            URLQueryItem(name: "sort", value: "-begin_at")
        ]
        return network.get(type: [Match].self, url: endpoint.url, headers: endpoint.headers)
    }
    
    func getMatch(id: String) -> AnyPublisher<Match, Error> {
        let endpoint: Endpoint = .match(id: id)
        return network.get(type: Match.self, url: endpoint.url, headers: endpoint.headers)
    }
}
