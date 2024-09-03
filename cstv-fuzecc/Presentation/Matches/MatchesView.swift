//
//  MatchesView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchesView<ViewModel: MatchesViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.matches) { match in
            MatchRowView(match: match)
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetchMatches()
        }
    }
}

#Preview {
    MatchesView<MockMatchesViewModel>(viewModel: MockMatchesViewModel())
}
