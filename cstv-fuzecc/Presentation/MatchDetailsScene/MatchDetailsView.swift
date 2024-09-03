//
//  MatchDetailsView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import SwiftUI

struct MatchDetailsView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: MatchDetailsViewModel
    
    var body: some View {
        Text("Hello, World!")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.coordinator.pop()
                    } label: {
                        Image("ic-arrow-left")
                    }
                }
            }
            .navigationTitle("League + Serie")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    MatchDetailsView()
//}
