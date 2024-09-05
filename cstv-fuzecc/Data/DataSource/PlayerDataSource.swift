//
//  PlayerDataSource.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation
import Resolver
import Combine

protocol PlayerDataSource: AnyObject {
    func getPlayers(team: String) -> AnyPublisher<[Player], Error>
}

class RemotePlayerDataSource: PlayerDataSource {
    @Injected private var network: NetworkProtocol
    
    func getPlayers(team: String) -> AnyPublisher<[Player], Error> {
        var endpoint: Endpoint = .players
        endpoint.queryItems = [
            URLQueryItem(name: "filter[team_id]", value: team),
            URLQueryItem(name: "filter[active]", value: "true")
        ]
        return network.get(type: [Player].self, url: endpoint.url, headers: endpoint.headers)
    }
}
