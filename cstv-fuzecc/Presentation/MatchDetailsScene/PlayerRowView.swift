//
//  PlayerRowView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import SwiftUI

struct PlayerRowView: View {
    private let alignment: Alignment
    private let player: Player
    
    init(alignment: Alignment, player: Player) {
        self.alignment = alignment
        self.player = player
    }
    
    var body: some View {
        ZStack {
            HStack {
                if alignment == .leading {
                    CachedAsyncImage(url: player.imageURL) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Image("ic-player-placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                        } else {
                            ProgressView().tint(.white)
                        }
                    }
                    .frame(width: 50, height: 50)
                }
                
                VStack(alignment: alignment == .leading ? .leading: .trailing) {
                    Text(player.nickname)
                        .font(.customFont(size: 14))
                        .bold()
                    Text(player.name)
                        .font(.customFont(size: 12))
                        .foregroundStyle(Color("MutedColor"))
                }
                .frame(maxWidth: .infinity, alignment: alignment)
                
                if alignment == .trailing {
                    CachedAsyncImage(url: player.imageURL) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Image("ic-player-placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                        } else {
                            ProgressView().tint(.white)
                        }
                    }
                    .frame(width: 50, height: 50)
                }
            }
            .background(Color("CardColor"))
            .clipShape(
                .rect(
                    topLeadingRadius: alignment == .leading ? 12: 0,
                    bottomLeadingRadius: alignment == .leading ? 12: 0,
                    bottomTrailingRadius: alignment == .trailing ? 12: 0,
                    topTrailingRadius: alignment == .trailing ? 12: 0
                ))
        }
        .padding([.top, .bottom], 6)
        .padding(.leading, alignment == .leading ? 12: 0)
        .padding(.trailing, alignment == .trailing ? 12: 0)
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    PlayerRowView(alignment: .leading)
//}
