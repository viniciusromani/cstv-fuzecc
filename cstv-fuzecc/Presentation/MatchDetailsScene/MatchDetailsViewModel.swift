//
//  MatchDetailsViewModel.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import Combine

protocol MatchDetailsViewModel: ObservableObject {
    var match: Match? { get set }
    func fetchMatch(id: String)
}

class RemoteMatchDetailsViewModel: MatchDetailsViewModel {
    @Published var match: Match?
    
    private let id: String
    private let service: MatchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(id: String, service: MatchServiceProtocol) {
        self.id = id
        self.service = service
    }
    
    func fetchMatch(id: String) {
        service.getMatch(id: id)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error): print("Error \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] match in
                guard let strong = self else { return }
                strong.match = match
            }
            .store(in: &cancellables)
    }
}

class MockMatchDetailsViewModel: MatchDetailsViewModel {
    @Published var match: Match?
    
    func fetchMatch(id: String) {
        print("Implement a mock on me!")
    }
}
