//
//  MatchesView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: MatchesViewModel
    
    var body: some View {
        AsyncContentView(source: viewModel) { matches in
            if matches.count <= 0 { let _ = print("estou aqui") }
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

//#Preview {
//    MatchesView()
//}
