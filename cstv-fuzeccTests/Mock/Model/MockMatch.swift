//
//  MockMatches.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import cstv_fuzecc

extension Match {
    static func mock() -> Match {
        return mockSorted().randomElement()!
    }
    
    static func mockSorted() -> [Match] {
        let formatter = CachedDateFormatter.shared.iso8601Formatter()
        return [
            Match(id: "1021248", status: "running", scheduledAt: formatter.date(from: "2024-09-05T10:30:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            Match(id: "1028863", status: "running", scheduledAt: formatter.date(from: "2024-09-05T10:45:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            Match(id: "1028862", status: "not_started", scheduledAt: formatter.date(from: "2024-09-05T13:30:00+0000")!, opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            Match(id: "1033344", status: "not_started", scheduledAt: formatter.date(from: "2024-09-05T14:00:00+0000")!, opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            Match(id: "1032767", status: "finished", scheduledAt: formatter.date(from: "2024-09-05T08:00:00+0000")!, opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock())
        ]
    }
    
    static func shuffled() -> [Match] {
        return mockSorted().shuffled()
    }
}
