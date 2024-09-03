//
//  MatchesView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchesView<ViewModel: MatchesViewModel>: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.matches) { match in
            MatchRowView(match: match) { id in
                self.coordinator.navigateToDetails(id: id)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Partidas")
        .onAppear {
            viewModel.fetchMatches()
        }
        .refreshable {
            viewModel.fetchMatches()
        }
    }
}

#Preview {
    MatchesView<MockMatchesViewModel>(viewModel: MockMatchesViewModel())
}
