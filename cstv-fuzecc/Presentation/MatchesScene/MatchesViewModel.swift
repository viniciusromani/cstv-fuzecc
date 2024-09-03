//
//  MatchesViewModel.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import Combine
import Resolver

class MatchesViewModel: Loadable {
    @Published var state: LoadingState<[Match]> = .idle
    
    @Injected private var service: MatchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: MatchServiceProtocol) {
        self.service = service
    }
    
    func load() {
        let formatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        let today = formatter.date(from: formatter.string(from: Date())) ?? Date()
        
        state = .loading
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
                case .failure(let error): 
                    self.state = .failed(error)
                case .finished: break
                }
            } receiveValue: { [weak self] matches in
                guard let strong = self else { return }
                strong.state = .loaded(strong.sort(matches: matches))
            }
            .store(in: &cancellables)
    }
    
    func sort(matches: [Match]) -> [Match] {
        let formatter = CachedDateFormatter.shared.matchScheduleFormatter()
        let sortOrder = ["running", "not_started", "finished", "postponed", "canceled"]
        
        return matches.sorted { lhs, rhs in
            if lhs.status == rhs.status {
                let lhsDate = formatter.date(from: formatter.string(from: lhs.scheduledAt)) ?? Date()
                let rhsDate = formatter.date(from: formatter.string(from: rhs.scheduledAt)) ?? Date()
                return lhsDate < rhsDate
            }
            
            let lhsStatus = sortOrder.firstIndex(of: lhs.status) ?? 0
            let rhsStatus = sortOrder.firstIndex(of: rhs.status) ?? 0
            return lhsStatus < rhsStatus
        }
    }
}
