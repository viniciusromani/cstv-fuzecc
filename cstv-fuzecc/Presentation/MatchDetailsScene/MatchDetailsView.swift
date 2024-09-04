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
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    VStack(spacing: 10) {
                        CachedAsyncImage(url: viewModel.match.opponents.first?.imageURL) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit()
                            } else if phase.error != nil {
                                Image("ic-team-placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            } else {
                                ProgressView().tint(.white)
                            }
                        }.frame(height: 60)
                        
                        Text(viewModel.match.opponents.first?.name ?? "-")
                            .font(.customFont(size: 10))
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                    
                    Text("vs")
                        .font(.customFont(size: 12))
                        .opacity(0.5)
    
                    VStack(spacing: 10) {
                        CachedAsyncImage(url: viewModel.match.opponents.last?.imageURL) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit()
                            } else if phase.error != nil {
                                Image("ic-team-placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            } else {
                                ProgressView().tint(.white)
                            }
                        }.frame(height: 60)
                        
                        Text(viewModel.match.opponents.last?.name ?? "-")
                            .font(.customFont(size: 10))
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                }
                
                
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
                            ForEach(result.team1) { player in
                                PlayerRowView(alignment: .trailing, player: player)
                            }
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(result.team2) { player in
                                PlayerRowView(alignment: .leading, player: player)
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
