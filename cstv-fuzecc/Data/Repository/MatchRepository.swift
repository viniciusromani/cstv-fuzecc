//
//  MatchRepository.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation
import Resolver
import Combine

class MatchRepository {
    @Injected private var remoteDataSource: RemoteMatchDataSource
    @Injected private var cacheDataSource: CacheMatchDataSource
    
    func getMatches(forceRemote: Bool = false) -> AnyPublisher<[Match], Error> {
        if forceRemote {
            return remoteDataSource.getMatches()
        }
        
        return cacheDataSource.getMatches()
            .flatMap { matches in
                if matches.count > 0 {
                    return Just(matches)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return self.remoteDataSource.getMatches()
                        .flatMap { matches in
                            self.cacheDataSource.save(matches: matches)
                            return Just(matches)
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        }.eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
