//
//  PlayerRepository.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation
import Resolver
import Combine

/**
 Since there is not utility, this class could've been hidden
 but it is still here to follow arch.
 */
class PlayerRepository {
    @Injected private var remoteDataSource: PlayerDataSource
    
    func getPlayers(team: String) -> AnyPublisher<[Player], Error> {
        remoteDataSource.getPlayers(team: team)
    }
}
