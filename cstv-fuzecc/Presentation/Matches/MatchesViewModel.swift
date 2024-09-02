//
//  MatchesViewModel.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import Combine

protocol MatchesViewModel: ObservableObject {
    var matches: [Match] { get set }
    func fetchMatches()
}

class RemoteMatchesViewModel: MatchesViewModel {
    @Published var matches: [Match] = []
    
    private let service: MatchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: MatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatches() {
        service.getMatches()
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error): print("Error \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] matches in
                print("success")
                self?.matches = matches
            }
            .store(in: &cancellables)
    }
}

class MockMatchesViewModel: MatchesViewModel {
    @Published var matches: [Match] = []
    
    func fetchMatches() {
        print("Implement a mock on me!")
    }
}
