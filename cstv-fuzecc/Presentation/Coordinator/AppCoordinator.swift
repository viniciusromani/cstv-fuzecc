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
        case details(Match)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .home: hasher.combine(0)
            case .details(let match): hasher.combine(match)
            }
        }
        
        static func == (lhs: AppCoordinator.Pages, rhs: AppCoordinator.Pages) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(page: Pages) -> some View {
        switch page {
        case .home:
            let viewModel = MatchesViewModel()
            MatchesView(viewModel: viewModel)
        case .details(let match):
            let viewModel = MatchDetailsViewModel(match: match)
            MatchDetailsView(viewModel: viewModel)
        }
    }
    
    func navigateToDetails(match: Match) {
        self.push(page: .details(match))
    }
}
