//
//  MatchService.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import Combine
import Resolver

protocol MatchServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getMatches() -> AnyPublisher<[Match], Error>
}

class MatchService: MatchServiceProtocol {
    @Injected var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
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
