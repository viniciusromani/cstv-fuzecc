//
//  cstv_fuzeccApp.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

@main
struct cstv_fuzeccApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: improve it with DI
            let network = RemoteNetwork()
            let service = MatchService(network: network)
            let viewModel = RemoteMatchesViewModel(service: service)
            MatchesView(viewModel: viewModel)
        }
    }
}
