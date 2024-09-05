//
//  MatchDetailsViewModel.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import Combine
import Resolver

class MatchDetailsViewModel: Loadable {
    @Published var state: LoadingState<(team1: [Player], team2: [Player])> = .idle
    
    let match: Match
    @Injected private var repository: PlayerRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(match: Match) {
        self.match = match
    }
    
    func load() {
        guard let team1Id = match.opponents.first?.id, 
                let team2Id = match.opponents.last?.id else {
            print("team ids not provided")
            return
        }
        
        state = .loading
        let team1Publisher = repository.getPlayers(team: team1Id)
        let team2Publisher = repository.getPlayers(team: team2Id)
        
        Publishers.Zip(team1Publisher, team2Publisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error): self?.state = .failed(error)
                case .finished: break
                }
            } receiveValue: { [weak self] result in
                guard let strong = self else { return }
                strong.state = .loaded((team1: result.0, team2: result.1))
            }
            .store(in: &cancellables)
    }
}
