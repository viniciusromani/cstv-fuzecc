//
//  MatchService.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import Combine
import Resolver

protocol PlayerServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getPlayers(team: String) -> AnyPublisher<[Player], Error>
}

class PlayerService: PlayerServiceProtocol {
    @Injected var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getPlayers(team: String) -> AnyPublisher<[Player], Error> {
        var endpoint: Endpoint = .players
        endpoint.queryItems = [
            URLQueryItem(name: "filter[team_id]", value: team),
            URLQueryItem(name: "filter[active]", value: "true")
        ]
        return network.get(type: [Player].self, url: endpoint.url, headers: endpoint.headers)
    }
}
