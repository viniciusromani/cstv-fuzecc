//
//  MatchesView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI
import Resolver

struct MatchesView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @InjectedObject var viewModel: MatchesViewModel
    
    var body: some View {
        AsyncContentView(source: viewModel) { matches in
            List(matches, id: \.id) { match in
                MatchRowView(match: match) {
                    self.coordinator.navigateToDetails(match: match)
                }
            }
            .listStyle(.plain)
            .refreshable { _ = await viewModel.refresh() }
        }
        .navigationTitle("Partidas")
        .onAppear { UIRefreshControl.appearance().tintColor = UIColor(Color.white) }
    }
}

#Preview {
    MatchesView()
}
