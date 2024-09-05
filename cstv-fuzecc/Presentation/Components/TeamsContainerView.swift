//
//  TeamsContainerView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import SwiftUI

struct TeamsContainerView: View {
    private let match: Match
    
    init(match: Match) {
        self.match = match
    }
    
    var body: some View {
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
    }
}

//#Preview {
//    TeamsContainerView()
//}
