//
//  AppCoordinator.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import SwiftUI
import Resolver

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
            let viewModel = MatchesViewModel(service: Resolver.resolve())
            MatchesView(viewModel: viewModel)
        case .details(let id):
            let viewModel = MatchDetailsViewModel(id: id, service: Resolver.resolve())
            MatchDetailsView(viewModel: viewModel)
        }
    }
    
    func navigateToDetails(id: String) {
        self.push(page: .details(id: id))
    }
}
