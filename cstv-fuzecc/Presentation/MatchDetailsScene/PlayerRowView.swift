//
//  PlayerRowView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import SwiftUI

struct PlayerRowView: View {
    private let alignment: Alignment
    private let horizontalAligment: HorizontalAlignment
    
    init(alignment: Alignment) {
        self.alignment = alignment
        self.horizontalAligment = alignment == .leading ? .leading: .trailing
    }
    
    var body: some View {
        ZStack {
            HStack {
                if alignment == .leading {
                    Image("ic-team-placeholder")
                        .resizable()
                        .scaledToFit().frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack(alignment: horizontalAligment) {
                    Text("Nickname")
                        .font(.customFont(size: 14))
                        .bold()
                    Text("Nome Jogador")
                        .font(.customFont(size: 12))
                        .foregroundStyle(Color("MutedColor"))
                }
                .frame(maxWidth: .infinity, alignment: alignment)
                
                if alignment == .trailing {
                    Image("ic-team-placeholder")
                        .resizable()
                        .scaledToFit().frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
        .listRowInsets(
            EdgeInsets(
                top: 6,
                leading: alignment == .leading ? 12: 0,
                bottom: 6,
                trailing: alignment == .trailing ? 12: 0
            ))
        .listRowSeparator(.hidden)
        .listRowBackground(Color("BackgroundColor"))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PlayerRowView(alignment: .leading)
}
