//
//  MatchDetailsViewModel.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import Combine

class MatchDetailsViewModel: Loadable {
    @Published var state: LoadingState<Match> = .idle
    
    private let id: String = ""
    private let service: MatchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(id: String, service: MatchServiceProtocol) {
        self.service = service
    }
    
    func load() {
        guard self.id != "" else {
            state = .failed(NSError(domain: "no id provided", code: 0))
            return
        }
        
        state = .loading
        service.getMatch(id: self.id)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error): self.state = .failed(error)
                case .finished: break
                }
            } receiveValue: { [weak self] match in
                guard let strong = self else { return }
                strong.state = .loaded(match)
            }
            .store(in: &cancellables)
    }
}
