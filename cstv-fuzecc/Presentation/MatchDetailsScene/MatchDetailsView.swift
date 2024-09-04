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
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(spacing: 10) {
                    CachedAsyncImage(url: "https://cdn.pandascore.co/images/team/image/132857/229px_sinners_academy_allmode.png") { phase in
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

                    Text("SINNERS Academy" ?? "-")
                        .font(.customFont(size: 10))
                        .multilineTextAlignment(.center)
                    
                }.frame(maxWidth: .infinity)
                
                Text("vs")
                    .font(.customFont(size: 12))
                    .opacity(0.5)
                
                VStack(spacing: 10) {
                    CachedAsyncImage(url: "https://cdn.pandascore.co/images/team/image/129356/1092px_dynamo_eclot_allmode.png") { phase in
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

                    Text("Dynamo Eclot" ?? "-")
                        .font(.customFont(size: 10))
                        .multilineTextAlignment(.center)
                    
                }.frame(maxWidth: .infinity)
            }
            .padding(12)
            
            Text("Hoje, 21:00")
                .font(.customFont(size: 12))
                .bold()
            
            HStack(spacing: 0) {
                List {
                    PlayerRowView(alignment: .trailing)
                }
                .listStyle(.plain)
                
                List {
                    PlayerRowView(alignment: .leading)
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, 24)
        .navigationTitle("United21 Season 19 2024")
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
