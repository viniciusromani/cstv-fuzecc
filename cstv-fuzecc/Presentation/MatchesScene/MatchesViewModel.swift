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
    
    @Injected private var repository: MatchRepository
    private var cancellables = Set<AnyCancellable>()
    
    func refresh() async -> [Match] {
        do {
            let matches = try await repository.getMatches(forceRemote: true).async()
            let sorted = sort(matches: matches)
            // view update
            await MainActor.run { state = .loaded(sorted) }
            return sorted
        } catch {
            return []
        }
    }
    
    func load() {
        let formatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        let today = formatter.date(from: formatter.string(from: Date())) ?? Date()
        
        state = .loading
        repository.getMatches()
            .receive(on: DispatchQueue.main)
            .map { matches in
                matches.filter { match in
                    let scheduled = formatter.date(from: formatter.string(from: match.scheduledAt)) ?? Date()
                    return scheduled >= today
                }
            }
            .sink { result in
                switch result {
                case .failure(let error): self.state = .failed(error)
                case .finished: break
                }
            } receiveValue: { [weak self] matches in
                guard let strong = self else { return }
                let sorted = strong.sort(matches: matches)
                strong.state = .loaded(sorted)
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
