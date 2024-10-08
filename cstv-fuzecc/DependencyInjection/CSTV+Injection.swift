//
//  AppDelegate+Injection.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        /**
         If application gets bigger we ought register resources by flow (or scene)
         https://github.com/hmlongco/Resolver/blob/master/Documentation/Registration.md#add-injection-files
         (or even clean layer; Service + Presentation - didnt do Domain for the sake of simplicity)
         */
        
        // core
        Resolver.register {
            RemoteNetwork()
        }.implements(NetworkProtocol.self)
        Resolver.register {
            InMemoryCache.shared
        }.implements(CacheProtocol.self)
        
        // datasource
        Resolver.register {
            RemoteMatchDataSource()
        }.implements(MatchDataSource.self)
        Resolver.register {
            CacheMatchDataSource()
        }.implements(MatchDataSource.self)
        Resolver.register {
            RemotePlayerDataSource()
        }.implements(PlayerDataSource.self)
        
        // repository
        Resolver.register {
            MatchRepository()
        }
        Resolver.register {
            PlayerRepository()
        }
        
        // viewModel
        Resolver.register {
            MatchesViewModel()
        }.scope(.shared)
        Resolver.register { (_, args) in
            MatchDetailsViewModel(match: args())
        }
        
        // view
        Resolver.register {
            MatchesView()
        }
        Resolver.register {
            MatchDetailsView(viewModel: Resolver.resolve())
        }
    }
}
