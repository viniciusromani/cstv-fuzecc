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
        Text("Hello, World!")
            .onAppear {
                viewModel.fetchMatches()
            }
    }
}

#Preview {
    MatchesView<MockMatchesViewModel>(viewModel: MockMatchesViewModel())
}
