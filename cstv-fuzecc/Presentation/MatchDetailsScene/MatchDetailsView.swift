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
    
    var emptyList: some View {
        Text("Sem jogadores cadastrados\n=(")
            .multilineTextAlignment(.center)
            .font(.customFont(size: 12))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                TeamsContainerView(match: viewModel.match)
                
                switch viewModel.match.status {
                case "running":
                    Text("AGORA")
                        .font(.customFont(size: 12))
                        .bold()
                case "not_started":
                    Text("Hoje, \(CachedDateFormatter.shared.matchScheduleFormatter().string(from: viewModel.match.scheduledAt))")
                        .font(.customFont(size: 12))
                        .bold()
                case "finished":
                    Text("FINALIZADO")
                        .font(.customFont(size: 12))
                        .bold()
                default: Text("-")
                }
                
                AsyncContentView(source: viewModel) { result in
                    HStack(alignment: .top, spacing: 0) {
                        VStack(spacing: 0) {
                            if result.team1.count == 0 {
                                emptyList
                            } else {
                                ForEach(result.team1) { player in
                                    PlayerRowView(alignment: .trailing, player: player)
                                }
                            }
                        }
                        
                        VStack(spacing: 0) {
                            if result.team2.count == 0 {
                                emptyList
                            } else {
                                ForEach(result.team2) { player in
                                    PlayerRowView(alignment: .leading, player: player)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 24)
        .navigationTitle("\(viewModel.match.league.name) \(viewModel.match.serie.name)")
        .navigationBarTitleDisplayMode(.inline)
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
    }
}

//#Preview {
//    MatchDetailsView()
//}
