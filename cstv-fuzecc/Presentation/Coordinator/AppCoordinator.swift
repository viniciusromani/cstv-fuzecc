//
//  AppCoordinator.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import SwiftUI

class AppCoordinator: Coordinator {
    enum Pages: PagesProtocol {
        case home
        case details(id: String)
    }
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(page: Pages) -> some View {
        switch page {
        case .home:
            // TODO: Improve with DI
            let network = RemoteNetwork()
            let service = MatchService(network: network)
            let viewModel = RemoteMatchesViewModel(service: service)
            MatchesView(viewModel: viewModel)
        case .details(let id):
            // TODO: Improve with DI
            let network = RemoteNetwork()
            let service = MatchService(network: network)
            let viewModel = RemoteMatchDetailsViewModel(id: id, service: service)
            MatchDetailsView(viewModel: viewModel)
        }
    }
    
    func navigateToDetails(id: String) {
        self.push(page: .details(id: id))
    }
}
