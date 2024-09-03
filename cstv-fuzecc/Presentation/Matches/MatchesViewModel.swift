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
        let formatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        let today = formatter.date(from: formatter.string(from: Date())) ?? Date()
        
        service.getMatches()
            .receive(on: DispatchQueue.main)
            .map { matches in
                matches.filter { match in
                    let scheduled = formatter.date(from: formatter.string(from: match.scheduledAt)) ?? Date()
                    return scheduled >= today
                }
            }
            .sink { result in
                switch result {
                case .failure(let error): print("Error \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] matches in
                guard let strong = self else { return }
                strong.matches = strong.sort(matches: matches)
            }
            .store(in: &cancellables)
    }
    
    func sort(matches: [Match]) -> [Match] {
        let formatter = CachedDateFormatter.shared.matchScheduleFormatter()
        
        return matches.sorted { lhs, rhs in
            if lhs.status == rhs.status {
                let lhsDate = formatter.date(from: formatter.string(from: lhs.scheduledAt)) ?? Date()
                let rhsDate = formatter.date(from: formatter.string(from: rhs.scheduledAt)) ?? Date()
                return lhsDate < rhsDate
            }
            
            let lhsStatus = ["running", "not_started", "finished"].firstIndex(of: lhs.status) ?? 0
            let rhsStatus = ["running", "not_started", "finished"].firstIndex(of: rhs.status) ?? 0
            return lhsStatus < rhsStatus
        }
    }
}

class MockMatchesViewModel: MatchesViewModel {
    @Published var matches: [Match] = []
    
    func fetchMatches() {
        print("Implement a mock on me!")
    }
}
