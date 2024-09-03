//
//  MatchRowView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchRowView: View {
    private let match: Match
    private let formatter: DateFormatter
    
    init(match: Match) {
        self.match = match
        let _formatter = DateFormatter()
        _formatter.timeZone = TimeZone.current
        _formatter.dateFormat = "HH:mm"
        self.formatter = _formatter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(
                    match.status == "running" ? "AGORA": "Hoje, \(formatter.string(from: match.scheduledAt))"
                )
                .padding(8)
                .background(
                    match.status == "running" ? Color("WarningColor"): .white.opacity(0.2)
                )
                .bold()
                .font(.customFont(size: 8))
                .clipShape(.rect(bottomLeadingRadius: 16))
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
        .listRowInsets(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .listRowBackground(Color("BackgroundColor"))
        .listRowSeparator(.hidden)
        .foregroundColor(Color("TextColor"))
        .background(Color("CardColor"))
        .cornerRadius(16)
    }
}

//#Preview {
//    MatchRowView(match: Match())
//}
