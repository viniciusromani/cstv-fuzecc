//
//  MatchRowView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchRowView: View {
    private let match: Match
    private let action: (_ id: String) -> Void
    
    init(match: Match, action: @escaping (_ id: String) -> Void) {
        self.match = match
        self.action = action
    }
    
    var body: some View {
        Button {
            self.action(match.id)
        } label: {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    switch match.status {
                    case "running":
                        Text("AGORA")
                            .padding(8)
                            .background(Color("WarningColor"))
                            .bold()
                            .font(.customFont(size: 8))
                            .clipShape(.rect(bottomLeadingRadius: 16))
                    case "not_started":
                        Text("Hoje, \(CachedDateFormatter.shared.matchScheduleFormatter().string(from: match.scheduledAt))")
                            .padding(8)
                            .background(.white.opacity(0.2))
                            .bold()
                            .font(.customFont(size: 8))
                            .clipShape(.rect(bottomLeadingRadius: 16))
                    case "finished":
                        Text("FINALIZADO")
                            .padding(8)
                            .background(Color("SuccessColor"))
                            .bold()
                            .font(.customFont(size: 8))
                            .clipShape(.rect(bottomLeadingRadius: 16))
                    default: Text("-")
                    }
                }
                HStack(spacing: 20) {
                    VStack(spacing: 10) {
                        CachedAsyncImage(url: match.opponents.first?.imageURL) { phase in
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
                        
                        Text(match.opponents.first?.name ?? "-")
                            .font(.customFont(size: 10))
                            .multilineTextAlignment(.center)
                        
                    }.frame(maxWidth: .infinity)
                    
                    Text("vs")
                        .font(.customFont(size: 12))
                        .opacity(0.5)
                    
                    VStack(spacing: 10) {
                        CachedAsyncImage(url: match.opponents.last?.imageURL) { phase in
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
                        
                        Text(match.opponents.last?.name ?? "-")
                            .font(.customFont(size: 10))
                            .multilineTextAlignment(.center)
                        
                    }.frame(maxWidth: .infinity)
                }
                .padding(12)
                Divider()
                    .background(Color.white)
                    .opacity(0.2)
                HStack(spacing: 8) {
                    CachedAsyncImage(url: match.league.imageURL) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Image("ic-league-placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16)
                        } else {
                            ProgressView().controlSize(.small).tint(.white)
                        }
                    }.frame(height: 16)
                    
                    Text("\(match.league.name) \(match.serie.name)")
                        .font(.customFont(size: 8))
                    Spacer()
                }
                .padding(8)
            }
        }
        .listRowInsets(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .listRowBackground(Color("BackgroundColor"))
        .listRowSeparator(.hidden)
        .background(Color("CardColor"))
        .cornerRadius(16)
    }
}

//#Preview {
//    MatchRowView(match: Match())
//}
