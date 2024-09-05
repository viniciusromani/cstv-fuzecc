//
//  MatchDataSource.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation
import Combine
import Resolver

protocol MatchDataSource: AnyObject {
    func getMatches() -> AnyPublisher<[Match], Error>
}

class RemoteMatchDataSource: MatchDataSource {
    @Injected private var network: NetworkProtocol
    
    func getMatches() -> AnyPublisher<[Match], Error> {
        let formatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        
        var endpoint: Endpoint = .matches
        endpoint.queryItems = [
            URLQueryItem(name: "filter[begin_at]", value: formatter.string(from: Date())),
            URLQueryItem(name: "sort", value: "begin_at")
        ]
        return network.get(type: [Match].self, url: endpoint.url, headers: endpoint.headers)
    }
}

class CacheMatchDataSource: MatchDataSource {
    @Injected private var cache: CacheProtocol
    private let kMatches = CachedDateFormatter.shared.fetchMatchesFilterFormatter().string(from: Date())
    
    func getMatches() -> AnyPublisher<[Match], Error> {
        var cached: [Match] = []
        if let _cached = cache.value(forKey: kMatches) as? [Match] {
            cached = _cached
        }
        
        return Just(cached)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func save(matches: [Match]) {
        cache.insert(matches, forKey: kMatches)
    }
}
