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
        
        Resolver.register {
            RemoteNetwork()
        }.implements(NetworkProtocol.self)
        
        Resolver.register { resolver in
            MatchService(network: resolver.resolve())
        }.implements(MatchServiceProtocol.self)
        Resolver.register { resolver in
            PlayerService(network: resolver.resolve())
        }.implements(PlayerServiceProtocol.self)
    }
}
