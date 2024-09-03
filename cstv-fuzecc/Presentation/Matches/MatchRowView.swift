//
//  MatchRowView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import SwiftUI

struct MatchRowView: View {
    private let match: Match
    
    init(match: Match) {
        self.match = match
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text(
                    match.status == "running" ? "AGORA": "Hoje, \(match.formattedTime)"
                )
                .padding(8)
                .background(
                    match.status == "running" ? Color("WarningColor"): .white.opacity(0.2)
                )
                .bold()
                .font(.customFont(size: 8))
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 16,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )
            }
            HStack(spacing: 20) {
                VStack {
                    Text("Time 1")
                    Text(match.opponents.first?.name ?? "-")
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity)
                Text("vs")
                    .font(.customFont(size: 12))
                    .opacity(0.5)
                VStack {
                    Text("Time 2")
                    Text(match.opponents.last?.name ?? "-")
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity)
            }
            .padding(12)
            Divider()
                .background(Color.white)
                .opacity(0.2)
            HStack(spacing: 8) {
                Text("image")
                Text("\(match.league.name) \(match.serie.name)")
                    .font(.customFont(size: 8))
                Spacer()
            }
            .padding(8)
        }
        .foregroundColor(Color("TextColor"))
        .background(Color("BackgroundColor"))
        .cornerRadius(16)
    }
}

//#Preview {
//    MatchRowView(match: Match())
//}
